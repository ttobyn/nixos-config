{ config, lib, pkgs, ... }:

{
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  programs.zsh.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelModules = [ "i2c-dev" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

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
    options = [ "rw" "uid=1000" "gid=100" "nofail" "force" ];
  };

  security.wrappers.jay = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_nice+ep";
    source = "${pkgs.jay}/bin/jay";
  };

  users.users."tobyn" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise.automatic = true;

  systemd.services.flatpak-update = {
    description = "Update Flatpak applications";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.flatpak}/bin/flatpak update -y --noninteractive";
    };
  };

  systemd.timers.flatpak-update = {
    description = "Run Flatpak update weekly";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };

  system.stateVersion = "26.05";
}
