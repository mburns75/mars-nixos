{
  description = "My Awesome Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true; 
      };
    };

    lib = nixpkgs.lib;

  in {
    homeManagerConfigurations = {
      dvader = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	extraSpecialArgs = { 
	  inherit inputs;
	};
	modules = [
	  ./users/dvader/home.nix
	  inputs.stylix.homeModules.stylix
	];
      };
    };

    nixosConfigurations = {
      mars = lib.nixosSystem {
        modules = [
          {
	    nixpkgs.hostPlatform = "x86_64-linux";
	  }
	  ./system/configuration.nix
	];
	specialArgs = { inherit inputs; };
      };
    };
  };
}
