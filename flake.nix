{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ inputs.nixos-flake.flakeModule ];

      flake =
        let
          myUserName = "scorp";
        in
        {
          # Configurations for Linux (NixOS) machines
          nixosConfigurations.Nyx = self.nixos-flake.lib.mkLinuxSystem {
            nixpkgs.hostPlatform = "x86_64-linux";
            imports = [
              ./hosts/Nyx/configuration.nix
              ({ pkgs, ... }: {
                users.users.${myUserName}.isNormalUser = true;
              })
              # Setup home-manager in NixOS config
              self.nixosModules.home-manager
              {
                home-manager.users.${myUserName} = {
                  imports = [ self.homeModules.default ];
                  home.stateVersion = "23.11";
                };
              }
            ];
          };

          # home-manager configuration goes here.
          homeModules.default = { pkgs, ... }: {
            imports = [ 
              ./home/zsh.nix
            ];
          };
        };
    };
}
