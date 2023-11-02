{
  description = "nekowinston's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nix = {
      url = "github:willruggiano/neovim.nix";
      inputs.flake-parts.follows = "flake-parts";
      inputs.neovim.follows = "";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit-nix.follows = "pre-commit-nix";
    };

    # LSP
    nixd = {
      url = "github:nekowinston/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    nekowinston-nur.url = "github:nekowinston/nur";
    bandithedoge-nur.url = "github:bandithedoge/nur-packages";

    # maintenance
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.neovim-nix.flakeModule
        ./neovim.nix
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        inputs',
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            (f: p: {
              repos = {
                nixd = inputs'.nixd.packages;
                bandithedoge = import inputs.bandithedoge-nur {inherit (p) pkgs;};
                nekowinston = import inputs.nekowinston-nur {inherit (p) pkgs;};
              };
            })
          ];
        };

        checks = {
          pre-commit-check = inputs.pre-commit-nix.lib.${system}.run {
            src = ./.;
            excludes = ["_sources/.+"];
            hooks = {
              alejandra.enable = true;
              stylua.enable = true;
            };
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (inputs.self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = with pkgs; [just nix-tree];
        };

        formatter = pkgs.alejandra;

        packages = rec {
          default = neovim;
          neovim = config.neovim.final;
          neovide = pkgs.callPackage ./pkgs/neovide {
            env = {
              NEOVIDE_FRAME = "none";
              NEOVIDE_MULTIGRID = "1";
              NEOVIM_BIN = "${neovim}/bin/nvim";
            };
          };
          nvim-treesitter = pkgs.callPackage ./pkgs/nvim-treesitter {};
          telescope-fzf-native = pkgs.callPackage ./pkgs/telescope-fzf-native {};
          markdown-preview = pkgs.callPackage ./pkgs/markdown-preview {};
        };
      };
    };

  nixConfig = {
    extra-substituters = [
      "https://bandithedoge.cachix.org"
      "https://nekowinston.cachix.org"
      "https://nix-community.cachix.org"
      "https://pre-commit-hooks.cachix.org"
    ];
    extra-trusted-public-keys = [
      "bandithedoge.cachix.org-1:ZtcHw1anyEa4t6H8m3o/ctYFrwYFPAwoENSvofamE6g="
      "nekowinston.cachix.org-1:lucpmaO+JwtoZj16HCO1p1fOv68s/RL1gumpVzRHRDs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
    ];
  };
}
