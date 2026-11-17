{ config, lib, pkgs, ... }:

let
  myPkgs = import ../../packages.nix { inherit pkgs; };
in
{
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
  environment.sessionVariables.XDG_DATA_DIRS = [
    "/var/lib/flatpak/exports/share"
  ];

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
      "--disable-dev-shm-usage"
      "--disable-features=RendererCodeIntegrity"
      "--disable-background-networking"
      "--disable-default-apps"
      "--disable-sync"
      "--disable-translate"
      "--metrics-recording-only"
      "--no-first-run"
    ];
  };

  programs.thunar.enable = true;
  programs.thunar.plugins = myPkgs.thunarPlugins;
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="3367", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3367", MODE="0666", TAG+="uaccess"
    # DrunkDeer A75 ISO - 352d:2383
    SUBSYSTEM=="usb", ATTRS{idVendor}=="352d", ATTRS{idProduct}=="2383", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="352d", ATTRS{idProduct}=="2383", MODE="0666", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="352d", ATTRS{idProduct}=="2383", MODE="0666", TAG+="uaccess"
  '';

  environment.systemPackages = myPkgs.apps;
  
  fonts.packages = myPkgs.fonts;
}