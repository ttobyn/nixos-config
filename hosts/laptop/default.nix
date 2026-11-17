{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/base.nix
    ../../modules/system/compositors.nix
    ../../modules/system/media.nix
    ../../modules/system/apps.nix
    ../../modules/system/vpn.nix
  ];

  # no gaming.nix / nvidia.nix on the laptop; stock kernel instead of cachyos
  networking.hostName = "laptop";

  # laptop i3status bar: no nvidia_gpu block, battery block after RAM
  home-manager.users.tobyn.home.file.".config/i3status-rust".source =
    lib.mkForce ../../dotfiles/i3status-rust-laptop;

  # laptop jay config: single 144Hz internal display, no nvidia bits
  home-manager.users.tobyn.home.file.".config/jay".source =
    lib.mkForce ../../dotfiles/jay-laptop;
}
