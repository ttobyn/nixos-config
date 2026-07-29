{ pkgs, ... }:

{
  hardware.graphics.enable32Bit = true;

  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
  '';

  environment.sessionVariables.PROTON_ENABLE_NVAPI = "1";

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt

    heroic
    prismlauncher
    waywall

    vulkan-tools
    winetricks
    pkgs.glfw3-minecraft
  ];
}
