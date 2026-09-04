{ pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.text;
    colorScheme = "";

    enabledExtensions = with spicePkgs.extensions; [
      lastfm
    ];

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
  };
}
