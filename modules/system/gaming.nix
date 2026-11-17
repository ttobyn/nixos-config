{ pkgs, ... }:
let
  myPkgs = import ../../packages.nix { inherit pkgs; };
in
{
 #native
  powerManagement.cpuFreqGovernor = "performance";
  hardware.graphics.enable32Bit = true;
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
    extraCompatPackages = myPkgs.steamCompat;
  };
  boot.kernelModules = [ "ntsync" ];
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  services.scx = {
    enable = true;
    scheduler = "scx_bpfland";
  };
  systemd.services.scx.serviceConfig.LimitMEMLOCK = "infinity";
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
  '';
  environment.sessionVariables.PROTON_ENABLE_NVAPI = "1";
  environment.systemPackages = myPkgs.gaming;
  boot.kernel.sysctl."vm.swappiness" = 1;

}
