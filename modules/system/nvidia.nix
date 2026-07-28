{ config, lib, pkgs, ... }:

{
  # RTX 3060 Ti (Ampere) - required for proper Wayland support
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
