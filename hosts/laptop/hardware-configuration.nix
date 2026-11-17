# PLACEHOLDER — replace this whole file with the output of
# `nixos-generate-config --root /mnt` run from the NixOS installer
# (copy its /mnt/etc/nixos/hardware-configuration.nix over this one).
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = lib.mkDefault {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };
}
