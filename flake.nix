{
  description = "My Awesome Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    elephant.url = "github:abenz1267/elephant";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true; 
    };

    lib = nixpkgs.lib;

  in {

    nixosConfigurations = {
      mars = lib.nixosSystem {
        inherit system;
	specialArgs = { inherit inputs; };
        modules = [
	  ./system/configuration.nix
	];
      };
    };

    homeManagerConfigurations = {
      dvader = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	extraSpecialArgs = { inherit inputs; };
	modules = [
	  ./users/dvader/home.nix
	  inputs.stylix.homeModules.stylix
	];
      };
    };
  };
}
