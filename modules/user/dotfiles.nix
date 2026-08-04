{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
  };

  home.file.".config/hypr".source = ../../dotfiles/hypr;
  home.file.".config/waybar".source = ../../dotfiles/waybar;
  home.file.".config/rofi".source = ../../dotfiles/rofi;
  home.file.".config/jay".source = ../../dotfiles/jay;
  home.file.".config/foot".source = ../../dotfiles/foot;
  home.file.".config/waywall".source = ../../dotfiles/waywall;
  home.file.".local/share/fonts".source = ../../dotfiles/fonts;
  home.file.".config/easyeffects".source = ../../dotfiles/easyeffects;
  home.file.".config/swappy".source = ../../dotfiles/swappy; 
  home.file.".config/i3status-rust".source = ../../dotfiles/i3status-rust;
  
}
