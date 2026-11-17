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
    bedrock-on-linux = {
      url = "github:Wyze3306/BedrockOnLinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    proton-cachyos = {
      url = "github:Daaboulex/proton-cachyos-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # do NOT add inputs.nixpkgs.follows here — patches are pinned to a specific nixpkgs rev
  };
  outputs = { nixpkgs, home-manager, helium-flake, spicetify-nix, agenix, bedrock-on-linux, nix-cachyos-kernel, proton-cachyos, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/nixos/default.nix
        helium-flake.nixosModules.default
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
        }
        {
          nixpkgs.overlays = [ (final: prev: {
            bedrock-on-linux = bedrock-on-linux.packages.x86_64-linux.default;
          }) ];
        }
        {
          nixpkgs.overlays = [ proton-cachyos.overlays.default ];
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

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/laptop/default.nix
        helium-flake.nixosModules.default
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
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
