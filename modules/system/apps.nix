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
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-volman
    thunar-archive-plugin
    thunar-media-tags-plugin
  ];
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

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
    p7zip
    cliphist
    wl-clipboard
     
    hyprsunset
    hyprpaper
    waybar
    i3status-rust
    swaybg
    adwaita-icon-theme
    
    obs-studio
    mpv
    grimblast
    grim
    slurp
    swappy
    
    ntfs3g
    strace
    
    firefox
    qbittorrent
    nicotine-plus

    ninbot
  ];
  
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}