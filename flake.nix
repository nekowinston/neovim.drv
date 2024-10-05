{
  description = "nekowinston's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nix = {
      url = "github:nekowinston/neovim.nix/36761e2fcd5e81fa3b39cb72d9fbcb92098edad8";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.git-hooks.follows = "git-hooks-nix";
      inputs.example.follows = "";
    };
    nvim-treesitter-nix = {
      url = "github:nekowinston/nvim-treesitter-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./neovim.nix
        inputs.git-hooks-nix.flakeModule
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
          self',
          config,
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              inputs.nvim-treesitter-nix.overlays.default
              # inputs.neovim-nightly-overlay.overlays.default
              (final: prev: { java-debug = final.callPackage ./pkgs/java-debug { }; })
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

          devShells.default = pkgs.mkShell {
            inherit (config.pre-commit.devShell) shellHook;
            packages = with pkgs; [
              self'.formatter
              nix-tree
              nvfetcher
            ];
          };

          formatter = pkgs.nixfmt-rfc-style;

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
                  NEOVIM_BIN = "${neovim}/bin/nvim";
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
              inherit (pkgs) java-debug;
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
