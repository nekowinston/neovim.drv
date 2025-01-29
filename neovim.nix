{
  config = {
    perSystem =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        neovim = {
          package = pkgs.neovim.override {
            withNodeJs = false;
            withPython3 = false;
            withRuby = false;
          };
          build.initlua = lib.mkForce (
            pkgs.writeText "init.lua" # lua
              ''
                vim.cmd.source("${./before.lua}")
                vim.cmd.source("${config.neovim.build.plugins}")
              ''
          );
          env = {
            JAVA_DEBUG_DIR = "${pkgs.java-debug}/share/java-debug";
            JAVA_TEST_DIR = "${pkgs.java-test}/share/java-test";
          };
          paths = with pkgs; [
            fd
            gitMinimal
            nushell
            ripgrep

            # lua
            lua-language-server
            stylua

            # nix
            nil
            nixfmt-rfc-style

            # shell scripting
            nodePackages.bash-language-server
            shellcheck
            shfmt

            # webdev
            emmet-language-server
            nodePackages.typescript
            nodePackages.vscode-langservers-extracted
            nodePackages.yaml-language-server

            # data formats
            taplo
          ];

          lazy = {
            package = (pkgs.callPackage ./pkgs/plugins { }).lazy-nvim;
            settings = {
              change_detection.enabled = false;
              checker.enabled = false;
              dev = {
                path = "~/Code/neovim";
                fallback = false;
              };
              pkg.enabled = false;
            };
            plugins = import ./plugins { inherit pkgs; };
          };
        };
      };
  };
}
