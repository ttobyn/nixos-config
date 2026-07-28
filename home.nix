{ config, pkgs, ... }:

{
  imports = [
    ./modules/user/zsh.nix
    ./modules/user/dotfiles.nix
    ./modules/user/fastfetch.nix
  ];

  home.username = "tobyn";
  home.homeDirectory = "/home/tobyn";
  home.stateVersion = "26.05";

  programs.git.enable = true;
}
