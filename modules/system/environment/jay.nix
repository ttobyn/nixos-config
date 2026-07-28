{ config, lib, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.jay ];

  environment.etc."wayland-sessions/jay.desktop".text = ''
    [Desktop Entry]
    Name=Jay
    Comment=Jay Wayland Compositor
    Exec=jay run
    Type=Application
  '';
}
