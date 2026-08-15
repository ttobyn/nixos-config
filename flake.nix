{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    # do NOT add inputs.nixpkgs.follows here — patches are pinned to a specific nixpkgs rev
  };
  outputs = { nixpkgs, home-manager, helium-flake, spicetify-nix, agenix, nix-cachyos-kernel, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/nixos/default.nix
        ./modules/system/cachyos-kernel.nix
        helium-flake.nixosModules.default
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
        }
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit spicetify-nix; };
            users.tobyn = import ./home.nix;
          };
        }
      ];
    };
  };
}
