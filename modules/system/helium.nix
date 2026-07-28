{ config, lib, pkgs, ... }:

{
  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
    ];
  };
}
