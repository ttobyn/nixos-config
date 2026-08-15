{ config, lib, pkgs, ... }:

{
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  age.secrets.surfsharkKey.file = ../../secrets/surfshark.key.age;

  networking.wg-quick.interfaces.surfshark-uk = {
    autostart = false;
    address = [ "10.14.0.2/16" ];
    privateKeyFile = config.age.secrets.surfsharkKey.path;
    dns = [ "162.252.172.57" "149.154.159.92" ];
    peers = [{
      publicKey = "iBJRXLZwXuWWrOZE1ZrAXEKMgV/z0WjG0Tks5rnWLBI=";
      allowedIPs = [ "0.0.0.0/0" ];
      endpoint = "uk-lon.prod.surfshark.com:51820";
      persistentKeepalive = 25;
    }];
  };

  networking.wg-quick.interfaces.surfshark-nl = {
    autostart = false;
    address = [ "10.14.0.2/16" ];
    privateKeyFile = config.age.secrets.surfsharkKey.path;
    dns = [ "162.252.172.57" "149.154.159.92" ];
    peers = [{
      publicKey = "Lxg3jAOKcBA9tGBtB6vEWMFl5LUEB6AwOpuniYn1cig=";
      allowedIPs = [ "0.0.0.0/0" ];
      endpoint = "nl-ams.prod.surfshark.com:51820";
      persistentKeepalive = 25;
    }];
  };

  networking.wg-quick.interfaces.surfshark-us = {
    autostart = false;
    address = [ "10.14.0.2/16" ];
    privateKeyFile = config.age.secrets.surfsharkKey.path;
    dns = [ "162.252.172.57" "149.154.159.92" ];
    peers = [{
      publicKey = "rhuoCmHdyYrh0zW3J0YXZK4aN3It7DD26TXlACuWnwU=";
      allowedIPs = [ "0.0.0.0/0" ];
      endpoint = "us-nyc.prod.surfshark.com:51820";
      persistentKeepalive = 25;
    }];
  };
}
