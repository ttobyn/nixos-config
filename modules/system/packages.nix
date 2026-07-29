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
    xarchiver
    unzip 
    gnutar

    kitty
    foot
    fastfetch
    bluetui
    btop

    waybar
    hyprsunset
    hyprpaper
    adwaita-icon-theme
    
    ntfs3g
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
