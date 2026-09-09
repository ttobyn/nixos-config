{ pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.text;
    colorScheme = "custom";
    customColorScheme = {
      accent = "ffffff";
      "accent-active" = "ffffff";
      "accent-inactive" = "121212";
      banner = "ffffff";
      "border-active" = "ffffff";
      "border-inactive" = "535353";
      header = "535353";
      highlight = "1a1a1a";
      main = "000000";
      notification = "ffffff";
      "notification-error" = "ffffff";
      subtext = "b3b3b3";
      text = "ffffff";
    };

    enabledExtensions = with spicePkgs.extensions; [
      lastfm
    ];

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
  };
}
