{
  description = "My Awesome Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    elephant.url = "github:abenz1267/elephant";
    stylix.url = "github:danth/stylix";
    nvf.url = "github:notashelf/nvf";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nvf, ... }: 
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

    packages."x86_64-linux".default =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
	modules = [ ./users/dvader/nvf-configuration.nix];
      }).neovim;

    nixosConfigurations = {
      mars = lib.nixosSystem {
        modules = [
	  {
	    nixpkgs.hostPlatform = "x86_64-linux";
	  }
	  ./system/configuration.nix
	  nvf.nixosModules.default
	];
	specialArgs = { inherit inputs; };
      };
    };
  };
}
