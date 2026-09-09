{ config, lib, pkgs, ... }:

let
  ninbot = pkgs.writeShellScriptBin "ninbot" ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
      pkgs.libxkbcommon
      pkgs.libx11
      pkgs.libxtst
      pkgs.libxi
      pkgs.libxt
    ]}:$LD_LIBRARY_PATH"
    export XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
    export _JAVA_AWT_WM_NONREPARENTING=1
    unset WAYLAND_DISPLAY
    unset WAYLAND_SOCKET
    exec ${pkgs.openjdk17}/bin/java \
      -Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel \
      -Dawt.useSystemAAFontSettings=on \
      -jar /etc/nixos/dotfiles/waywall/resources/Ninjabrain-Bot-1.5.2.jar "$@"
  '';
  eggDesktop = pkgs.makeDesktopItem {
    name = "eggmouseconfig";
    exec = "EGGMouseConfig";
    desktopName = "EGG Mouse Config";
    comment = "Configure EGG XM2/OP1 8k mice";
    categories = [ "Settings" "HardwareSettings" ];
  };
  eggmouse = pkgs.stdenv.mkDerivation {
    pname = "unofficial-egg-mouse-config";
    version = "2026-08-22";
    src = pkgs.fetchFromGitHub {
      owner = "niansa";
      repo = "UnofficialEGGMouseConfig";
      rev = "98c48d301f525cab536d38d407558489ad2cac6f";
      hash = "sha256-oELr1B36Ll4EKbTlnGMF+elGsAuJzjvk/udJKZcd6Q4=";
      fetchSubmodules = true;
    };
    nativeBuildInputs = with pkgs; [ cmake pkg-config git ];
    buildInputs = with pkgs; [ glfw freetype hidapi libGL ];
    cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];
    postPatch = ''
      substituteInPlace CMakeLists.txt \
        --replace "/usr/include/freetype2" "${pkgs.freetype.dev}/include/freetype2"
    '';
    installPhase = ''
      runHook preInstall
      install -Dm755 EGGMouseConfig -t $out/bin
      install -Dm644 ${eggDesktop}/share/applications/* -t $out/share/applications
      runHook postInstall
    '';
  };
in
{
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
  environment.sessionVariables.XDG_DATA_DIRS = [
    "/var/lib/flatpak/exports/share"
  ];

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
      "--disable-dev-shm-usage"
      "--disable-features=RendererCodeIntegrity"
      "--disable-background-networking"
      "--disable-default-apps"
      "--disable-sync"
      "--disable-translate"
      "--metrics-recording-only"
      "--no-first-run"
    ];
  };

  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [
    thunar-volman
    thunar-archive-plugin
    thunar-media-tags-plugin
  ];
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="3367", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3367", MODE="0666", TAG+="uaccess"
    # DrunkDeer A75 ISO - 352d:2383
    SUBSYSTEM=="usb", ATTRS{idVendor}=="352d", ATTRS{idProduct}=="2383", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="352d", ATTRS{idProduct}=="2383", MODE="0666", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="352d", ATTRS{idProduct}=="2383", MODE="0666", TAG+="uaccess"
  '';

  environment.systemPackages = with pkgs; [
    foot
    fastfetch
    bluetui
    btop
    opencode
    
    vim
    gedit
    wget
    git
    
    ffmpegthumbnailer
    usbutils
    libimobiledevice
    ifuse
    glib # for gio mount afc://
    p7zip
    cliphist
    wl-clipboard
     
    i3status-rust
    swaybg
    adwaita-icon-theme
    
    obs-studio
    mpv
    grim
    slurp
    swappy
    
    ntfs3g
    strace
    
    qbittorrent
    nicotine-plus

    ninbot
    eggmouse
  ];
  
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}