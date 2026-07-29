{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/nvidia.nix
    ../../modules/system/environment
    ../../modules/system/helium.nix
    ../../modules/system/shell.nix
    ../../modules/system/packages.nix
    ../../modules/system/ly.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/audio.nix
    ../../modules/system/gaming.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  fileSystems."/mnt/arch" = {
    device = "/dev/disk/by-uuid/d68ad949-dc7b-4abe-8336-2789cf2be479";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/corsair_mp600" = {
    device = "/dev/disk/by-uuid/50906c8a-2070-4092-a2a8-6bba0e29ae7d";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  fileSystems."/mnt/main_storage" = {
    device = "/dev/disk/by-uuid/5664518C64516FAB";
    fsType = "ntfs3";
    options = [ "rw" "uid=1000" "gid=100" "nofail" ];
  };

  users.users."tobyn" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
