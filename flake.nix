{
  description = "cullvox's nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    utils,
    home-manager,
  }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      # Modules shared between all hosts
      hostDefaults.modules = [
        home-manager.nixosModules.home-manager
        ./nixos
      ];

      # Prometheus is my powerful computer
      hosts.prometheus = {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/prometheus
          ./nixos/modules/desktop/xserver.nix
          ./nixos/modules/desktop/i3.nix
          ./nixos/modules/applications.nix
        ];
      };

      # Helios is my server computer
      hosts.helios = {
        system = "x86_64-linux";
      };
    };
}
