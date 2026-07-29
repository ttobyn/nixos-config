{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    gedit
    wget
    git
    
    pcmanfm
    gvfs
    shared-mime-info
    unzip 
    gnutar
    
    qbittorrent
    nicotine-plus

    kitty
    foot
    fastfetch
    bluetui
    btop
    
    hyprsunset
    hyprpaper
    grimblast
    waybar
    adwaita-icon-theme
    
    ntfs3g
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
