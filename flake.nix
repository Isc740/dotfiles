{
  description = "My Main Flake Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05"; 
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    nix-gaming.url = "github:fufexan/nix-gaming";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    
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
              home-manager = {
                # useGlobalPkgs = true;
                # useUserPackages = true;
                users.isaac = import ./home/home.nix;
              };
            }
          ];
        };
      };
    };
}
