{ config, pkgs, ... }:

{
  imports = [
    ./modules/user/zsh.nix
    ./modules/user/dotfiles.nix
    ./modules/user/fastfetch.nix
    ./modules/user/spotify.nix   
  ];

  home.pointerCursor = {
    gtk.enable = true;

    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
};

  home.username = "tobyn";
  home.homeDirectory = "/home/tobyn";
  home.stateVersion = "26.05";

  programs.git.enable = true;
}
