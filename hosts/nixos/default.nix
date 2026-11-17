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

  # cachyos gaming kernel (needs the nix-cachyos-kernel overlay from flake.nix)
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
}
