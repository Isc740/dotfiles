{
  description = "My Main Flake Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager = {
      url = github:nix-community/home-manager/release-23.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {
        MonixOS = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
	  modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              #home-manager.useGlobalPkgs = true;
              #home-manager.useUserPackages = true;
              home-manager.users.isaac = import ./home-manager/home.nix;
            }
          ];
        };
      };

      # homeConfigurations = {
      #   isaac = home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;
      #     modules = [
      #       ./home-manager/home.nix
      #     ];
      #   };
      # };
    };
}
