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
  # Hyprland's module used to auto-enable xdg.portal, which Flatpak
  # asserts on — keep portals explicitly for file choosers et al.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  #Jay
  environment.systemPackages = [ pkgs.jay pkgs.xwayland ];
  services.displayManager.sessionPackages = [ jaySession ];
}
