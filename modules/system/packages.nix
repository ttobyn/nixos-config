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

    kitty
    foot
    fastfetch
    bluetui

    waybar
    hyprsunset
    hyprpaper
    adwaita-icon-theme
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
