{ pkgs, ... }:
{
 #native
  powerManagement.cpuFreqGovernor = "performance";
  hardware.graphics.enable32Bit = true;
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  boot.kernelModules = [ "ntsync" ];
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
  '';
  environment.sessionVariables.PROTON_ENABLE_NVAPI = "1";
  environment.systemPackages = with pkgs; [
    (prismlauncher.override { jdks = [ pkgs.jdk17 ]; })
    waywall
    vulkan-tools
    winetricks
    pkgs.glfw3-minecraft
    heroic
    bedrock-on-linux
    mangohud
  ];

  #flatpak
  systemd.services.flatpak-sober = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      if ! flatpak info org.vinegarhq.Sober >/dev/null 2>&1; then
        flatpak install --system -y --noninteractive flathub org.vinegarhq.Sober
      fi
    '';
    serviceConfig.Type = "oneshot";
  };
}
