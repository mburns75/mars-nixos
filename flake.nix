{
  description = "My Awesome Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in {
    homeManagerConfigurations = {
      dvader = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	modules = [
	  ./users/dvader/home.nix 
	];
      };
    };

    nixosConfigurations = {
      mars = lib.nixosSystem {
        inherit system;
	specialArgs = { inherit inputs; };
	modules = [
          ./system/configuration.nix
	];
      };
    };
  };
}
