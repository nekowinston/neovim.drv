{
  description = "nekowinston's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        hercules-ci-effects.follows = "";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "";
      };
    };
    neovim-nix = {
      url = "github:willruggiano/neovim.nix";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        git-hooks.follows = "git-hooks";
        example.follows = "";
      };
    };
    git-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./neovim.nix
        inputs.git-hooks.flakeModule
        inputs.neovim-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          inputs',
          lib,
          pkgs,
          self',
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              (final: prev: {
                inherit (inputs'.nixpkgs-master.legacyPackages) vimPlugins;
              })
              (import ./pkgs/overlays.nix)
              inputs.neovim-nightly-overlay.overlays.default
            ];
          };

          pre-commit = {
            settings = {
              excludes = [ "_sources/.+" ];
              hooks = {
                nixfmt-rfc-style.enable = true;
                stylua.enable = true;
              };
            };
          };

          devShells.default = pkgs.mkShellNoCC {
            inherit (config.pre-commit.devShell) shellHook;
            packages = with pkgs; [
              self'.formatter
              nix-tree
              nvfetcher
            ];
          };

          formatter = pkgs.nixfmt-rfc-style;

          legacyPackages = pkgs;

          packages =
            let
              neovim = config.neovim.final;
            in
            {
              default = neovim;
              neovim = neovim;
              neovide = pkgs.callPackage ./pkgs/neovide {
                env = {
                  NEOVIDE_FRAME = "none";
                  NEOVIDE_MULTIGRID = "1";
                  NEOVIM_BIN = lib.getExe pkgs.neovim;
                };
              };
              docker = pkgs.dockerTools.buildImage {
                name = "nekowinston-nvim";
                copyToRoot =
                  (with pkgs.dockerTools; [
                    usrBinEnv
                    binSh
                    caCertificates
                    fakeNss
                  ])
                  ++ [ neovim ];
              };
            };
        };
    };

  nixConfig = {
    extra-substituters = [
      "https://attic.winston.sh/public"
      "https://nix-community.cachix.org"
      "https://pre-commit-hooks.cachix.org"
    ];
    extra-trusted-public-keys = [
      "public:gqpCDffg2eWolOCakuF0FhU0hmPHvOiBy2Z2rpyf8Mg="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
    ];
  };
}
