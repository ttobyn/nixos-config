{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/user/spotify.nix
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;

    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
};

  home.username = "tobyn";
  home.homeDirectory = "/home/tobyn";
  home.stateVersion = "26.05";

  programs.git.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos --show-trace -L";
      update = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake";
      vpn-uk = "sudo systemctl start wg-quick-surfshark-uk";
      vpn-nl = "sudo systemctl start wg-quick-surfshark-nl";
      vpn-us = "sudo systemctl start wg-quick-surfshark-us";
      vpn-off = "sudo systemctl stop wg-quick-surfshark-uk wg-quick-surfshark-nl wg-quick-surfshark-us";
      ssh-pi = "TERM=xterm-256color ssh root@192.168.50.102";
    };
    initContent = ''
      fastfetch

      eval "$(starship init zsh)"

      commit() {
        git add -A
        git commit -m "''${*:-update}"
        git push
      }
    '';
  };

  home.packages = with pkgs; [
    rofi
    starship
  ];
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "white"; };
    };
    gtk3.extraCss = ''
      @define-color window_bg_color #000000;
      @define-color window_fg_color #ffffff;
      @define-color view_bg_color #000000;
      @define-color view_fg_color #ffffff;
      @define-color headerbar_bg_color #000000;
      @define-color headerbar_fg_color #ffffff;
      @define-color headerbar_backdrop_color #000000;
      @define-color sidebar_bg_color #000000;
      @define-color sidebar_fg_color #ffffff;
      @define-color sidebar_backdrop_color #000000;
      @define-color dialog_bg_color #000000;
      @define-color dialog_fg_color #ffffff;
      @define-color popover_bg_color #000000;
      @define-color popover_fg_color #ffffff;
      @define-color card_bg_color #000000;
      @define-color card_fg_color #ffffff;
      @define-color tooltip_bg_color #000000;
      @define-color tooltip_fg_color #ffffff;
      @define-color content_view_bg #000000;
      @define-color thumbnail_bg_color #000000;
      @define-color theme_bg_color #000000;
      @define-color theme_base_color #000000;
      @define-color theme_fg_color #ffffff;
      @define-color theme_text_color #ffffff;
      @define-color theme_unfocused_bg_color #000000;
      @define-color theme_unfocused_base_color #000000;
      @define-color theme_unfocused_fg_color #ffffff;
      @define-color theme_unfocused_text_color #ffffff;
      @define-color borders #111111;
      @define-color theme_borders #111111;
      @define-color unfocused_borders #111111;
      @define-color shade_color rgba(0,0,0,0);
      @define-color theme_selected_bg_color #ffffff;
      @define-color theme_selected_fg_color #000000;
      @define-color theme_unfocused_selected_bg_color #ffffff;
      @define-color theme_unfocused_selected_fg_color #000000;
      @define-color accent_color #ffffff;
      @define-color accent_bg_color #ffffff;
      @define-color accent_fg_color #000000;
      selection {
        background-color: #ffffff;
        color: #000000;
      }
      .view:selected,
      .view row:selected,
      treeview.view:selected,
      treeview.view row:selected {
        background-color: #ffffff;
        color: #000000;
      }
    '';
    gtk4.extraCss = ''
      @define-color window_bg_color #000000;
      @define-color window_fg_color #ffffff;
      @define-color view_bg_color #000000;
      @define-color view_fg_color #ffffff;
      @define-color headerbar_bg_color #000000;
      @define-color headerbar_fg_color #ffffff;
      @define-color sidebar_bg_color #000000;
      @define-color sidebar_fg_color #ffffff;
      @define-color dialog_bg_color #000000;
      @define-color dialog_fg_color #ffffff;
      @define-color popover_bg_color #000000;
      @define-color popover_fg_color #ffffff;
      @define-color card_bg_color #000000;
      @define-color card_fg_color #ffffff;
      @define-color content_view_bg #000000;
      @define-color theme_bg_color #000000;
      @define-color theme_base_color #000000;
      @define-color theme_fg_color #ffffff;
      @define-color theme_text_color #ffffff;
      @define-color theme_selected_bg_color #ffffff;
      @define-color theme_selected_fg_color #000000;
      @define-color accent_color #ffffff;
      @define-color accent_bg_color #ffffff;
      @define-color accent_fg_color #000000;
      selection {
        background-color: #ffffff;
        color: #000000;
      }
      .view:selected,
      .view row:selected,
      treeview.view:selected,
      treeview.view row:selected {
        background-color: #ffffff;
        color: #000000;
      }
    '';
  };
  home.file.".config/hypr".source = ../../dotfiles/hypr;
  home.file.".config/waybar".source = ../../dotfiles/waybar;
  home.file.".config/rofi".source = ../../dotfiles/rofi;
  home.file.".config/jay".source = ../../dotfiles/jay;
  home.file.".config/foot".source = ../../dotfiles/foot;
  home.file.".config/waywall".source = ../../dotfiles/waywall;
  home.file.".config/fastfetch".source = ../../dotfiles/fastfetch;
  home.file.".config/starship".source = ../../dotfiles/starship;
  home.file.".local/share/fonts".source = ../../dotfiles/fonts;
  home.file.".local/share/wallpapers".source = ../../assets/wallpapers;
  home.file.".config/easyeffects".source = ../../dotfiles/easyeffects;
  home.file.".config/swappy".source = ../../dotfiles/swappy; 
  home.file.".config/i3status-rust".source = ../../dotfiles/i3status-rust;
  home.file.".config/opencode/opencode.jsonc".source =
    ../../dotfiles/opencode/opencode.jsonc;
}