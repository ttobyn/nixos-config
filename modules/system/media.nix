{ pkgs, lib, ... }:
let
  myPkgs = import ../../packages.nix { inherit pkgs; };
in
{
  security.rtkit.enable = true;

  services.jellyfin.enable = true;
  networking.firewall.allowedTCPPorts = [ 8096 ];
  users.users.jellyfin.extraGroups = [ "video" "render" ];
  systemd.services.jellyfin.wantedBy = lib.mkForce [];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = myPkgs.media;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
}