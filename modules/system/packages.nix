{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
  environment.sessionVariables.XDG_DATA_DIRS = [
    "/var/lib/flatpak/exports/share"
  ];

  environment.systemPackages = with pkgs; [
    foot
    fastfetch
    bluetui
    btop
    
    vim
    gedit
    wget
    git
    
    pcmanfm
    shared-mime-info
    p7zip
    xarchiver
    
    hyprsunset
    hyprpaper
    waybar
    i3status-rust
    swaybg
    adwaita-icon-theme
    
    grimblast
    grim
    slurp
    swappy
    ddcutil
    
    ntfs3g
    strace
    
    qbittorrent
    nicotine-plus
  ];
  
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
