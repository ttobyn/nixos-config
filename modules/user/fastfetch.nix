# modules/user/fastfetch.nix
{ config, pkgs, ... }:
{
  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "padding": { "right": 1 },
        "color": {
          "1": "38;5;8",
          "2": "white",
          "3": "38;5;8",
          "4": "white",
          "5": "38;5;8",
          "6": "white",
          "7": "38;5;8",
          "8": "white",
          "9": "38;5;8"
        }
      },
      "display": {
        "separator": "  ",
        "color": {
          "keys": "38;5;8",
          "title": "38;5;8",
          "output": "white"
        }
      },
      "modules": [
        "os",
        "wm",
        "kernel",
        {
          "type": "command",
          "key": "Age",
          "text": "echo $(( ($(date +%s) - $(stat -c %W /)) / 86400 )) days"
        },
        "uptime",
        "memory",
        "cpu",
        "gpu"
      ]
    }
  '';
}
