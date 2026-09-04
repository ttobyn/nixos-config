{ pkgs, ... }:

let
  jaySession = pkgs.writeTextFile {
    name = "jay-wayland-session";
    destination = "/share/wayland-sessions/jay.desktop";
    text = ''
      [Desktop Entry]
      Name=Jay
      Comment=Jay Wayland Compositor
      Exec=jay run
      Type=Application
    '';
    passthru.providedSessions = [ "jay" ];
  };
in
{
  #Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  #Jay
  environment.systemPackages = [ pkgs.jay ];
  services.displayManager.sessionPackages = [ jaySession ];
}
