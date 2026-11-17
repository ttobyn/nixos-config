{ config, ... }:
{
  #RTX 3060ti
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    nvidiaPersistenced = true;
    powerManagement.enable = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  systemd.services.nvidia-power-limit = {
    description = "Cap NVIDIA GPU power limit";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    wants = [ "nvidia-persistenced.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${config.hardware.nvidia.package.bin}/bin/nvidia-smi -pl 180";
    };
  };
}
