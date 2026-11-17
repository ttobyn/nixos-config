{ pkgs, ... }:

let
  myPkgs = import ../../packages.nix { inherit pkgs; };
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
  services.displayManager.ly.enable = true;

  # Hyprland's module used to auto-enable xdg.portal, which Flatpak
  # asserts on — keep portals explicitly for file choosers et al.
  xdg.portal = {
    enable = true;
    extraPortals = myPkgs.portals;
    config.common.default = "*";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  #Jay
  environment.systemPackages = myPkgs.compositors;
  services.displayManager.sessionPackages = [ jaySession ];
}
