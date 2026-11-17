{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/base.nix
    ../../modules/system/compositors.nix
    ../../modules/system/media.nix
    ../../modules/system/apps.nix
    ../../modules/system/vpn.nix
  ];

  # no gaming.nix / nvidia.nix on the laptop; stock kernel instead of cachyos
  networking.hostName = "laptop";
}
