{ pkgs }:
let
  ninbot = pkgs.callPackage ./pkgs/ninbot.nix { };
  eggmouse = pkgs.callPackage ./pkgs/eggmouse.nix { };
  osu-collect = pkgs.callPackage ./pkgs/osu-collect.nix { };
in
with pkgs; {
  ##apps
  apps = [
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
    glib
    p7zip
    file-roller
    unzip
    zip
    cliphist
    wl-clipboard
    i3status-rust
    swaybg
    adwaita-icon-theme
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
    osu-collect
    librewolf
  ];

  ##gaming
  gaming = [
    (prismlauncher.override { jdks = [ jdk17 ]; })
    waywall
    vulkan-tools
    winetricks
    glfw3-minecraft
    heroic
    bedrock-on-linux
    mangohud
    osu-lazer-bin
  ];

  ##gaming-steam-compat
  steamCompat = [
    proton-ge-bin
    proton-cachyos-v3
  ];

  ##media
  media = [
    easyeffects
    qpwgraph
    playerctl
  ];

  ##compositors
  compositors = [
    jay
    xwayland
  ];

  ##portals
  portals = [
    xdg-desktop-portal-gtk
  ];

  ##home
  home = [
    rofi
    starship
  ];

  ##gtk
  gtkPkgs = [
    adw-gtk3
  ];

  ##base
  userTobyn = [
    tree
  ];

  ##fonts
  fonts = [
    nerd-fonts.jetbrains-mono
  ];

  ##thunar
  thunarPlugins = [
    thunar-volman
    thunar-archive-plugin
    thunar-media-tags-plugin
  ];
}
