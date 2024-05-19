# Functions that build packages are derivations
# Installed packages are never changed
#   This fact means updates in Nix are atomic since there isnt a time when half the system differes from the other

# Default.nix defines how a package is build
#  This file is translated into a store derivation (more primative)

{
	description = "Testing Flakes";
	inputs = {
		# Use the 23.11 branch of the official package repo
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		# Makesure packages referenced in nixpkgs and home-manager are the same
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # Neovim
        #nixvim = {
          #url = "github:nix-community/nixvim/nixos-23.11";
          #follows = "nixpkgs";
        #};

	};
	outputs = { self, nixpkgs, home-manager, ...}@inputs: 
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations.hathsin = nixpkgs.lib.nixosSystem {
			inherit system;
			# module nix files
			modules = [
				./configuration.nix	
			];
		};
		homeConfigurations = {
			kami = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
                modules = [ 
                  ./home.nix 
                ];
			};
		};
	};
}
