let
  tobyn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMcIgXPSxfY/PXkwtUNtJVks2SWxLrsEhnL+ePCpo2a root@nixos";
in
{
  "secrets/surfshark.key.age".publicKeys = [ tobyn ];
}
