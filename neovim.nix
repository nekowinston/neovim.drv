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
                local rtp = vim.api.nvim_get_runtime_file("", true)
                table.insert(rtp, #rtp + 1, "${./config}")
                table.insert(rtp, #rtp + 1, "${./config}/after")
                vim.opt.rtp = rtp

                vim.g.config_dir = "${./config}"
                vim.g.java_debug_dir = "${pkgs.java-debug}/share/java-debug"
                vim.g.java_test_dir = "${pkgs.java-test}/share/java-test"

                vim.cmd.source("${./config/plugin/init.lua}")
                vim.cmd.source("${config.neovim.build.plugins}")
              ''
          );
          paths = with pkgs; [
            fd
            gitMinimal
            ripgrep

            # lua
            lua-language-server
            stylua

            # nix
            nixd
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
