{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/base.nix
    ../../modules/system/nvidia.nix
    ../../modules/system/compositors.nix
    ../../modules/system/gaming.nix
    ../../modules/system/media.nix
    ../../modules/system/apps.nix
    ../../modules/system/vpn.nix
  ];
}
