# modules/user/zsh.nix
{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      test = "echo Working";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      test = "echo Working";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    };
    initContent = ''
      fastfetch

      commit() {
        git add -A
        git commit -m "''${*:-update}"
        git push
      }
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$character";
      character = {
        success_symbol = "[\\$](bold white)";
        error_symbol = "[\\$](bold red)";
      };
      directory = {
        style = "bold green";
        truncation_length = 2;
      };
    };
  };
}
