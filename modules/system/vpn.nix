{ config, ... }:

let
  dnsServers = [ "162.252.172.57" "149.154.159.92" ];

  # key = wg-quick interface name; endpoint/publicKey come from Surfshark's config generator
  regions = {
    surfshark-uk = {
      endpoint = "uk-lon";
      publicKey = "iBJRXLZwXuWWrOZE1ZrAXEKMgV/z0WjG0Tks5rnWLBI=";
    };
    surfshark-nl = {
      endpoint = "nl-ams";
      publicKey = "Lxg3jAOKcBA9tGBtB6vEWMFl5LUEB6AwOpuniYn1cig=";
    };
    surfshark-us = {
      endpoint = "us-nyc";
      publicKey = "rhuoCmHdyYrh0zW3J0YXZK4aN3It7DD26TXlACuWnwU=";
    };
  };

  wgInterface = region: {
    autostart = false;
    address = [ "10.14.0.2/16" ];
    privateKeyFile = config.age.secrets.surfsharkKey.path;
    dns = dnsServers;
    peers = [{
      allowedIPs = [ "0.0.0.0/0" ];
      publicKey = region.publicKey;
      endpoint = "${region.endpoint}.prod.surfshark.com:51820";
      persistentKeepalive = 25;
    }];
  };
in
{
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.surfsharkKey.file = ../../secrets/surfshark.key.age;

  networking.wg-quick.interfaces = builtins.mapAttrs (_name: region: wgInterface region) regions;
}
