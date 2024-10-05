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
          build.initlua = lib.mkForce (
            pkgs.writeText "init.lua" ''
              vim.opt.exrc = true
              vim.cmd.source "${config.neovim.build.before}"
              vim.cmd.source "${config.neovim.build.plugins}"
            ''
          );
          env.JAVA_DEBUG_JAR = "${pkgs.java-debug}/share/java-debug/java-debug.jar";
          paths = with pkgs; [
            fd
            gh
            git
            nushell
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
            nodePackages."@astrojs/language-server"
            nodePackages."@tailwindcss/language-server"
            nodePackages.graphql-language-service-cli
            nodePackages.typescript
            nodePackages.vscode-langservers-extracted
            nodePackages.yaml-language-server
            nodejs

            # data formats
            nodePackages.dockerfile-language-server-nodejs
            taplo

            # java etc
            gradle-language-server
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
            };
            plugins = import ./plugins { inherit pkgs; };
          };
        };
      };
  };
}
