{ config, pkgs, ... }:

{
  imports = [
    ./nvidia.nix
    ./compositors.nix
  ];

  services.displayManager.ly.enable = true;
}
