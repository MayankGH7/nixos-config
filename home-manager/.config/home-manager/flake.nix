{
  description = "Home Manager configuration of mynk";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangowc = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wiremix = {
      url = "github:tsowell/wiremix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, vicinae, mangowc, wiremix,  ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
      homeConfigurations."mynk" = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;

	modules = [ 
	  ./home.nix
	];

	extraSpecialArgs = {
	  inherit vicinae;
	  inherit mangowc;
	  inherit wiremix;
	};
      };
    };
}
