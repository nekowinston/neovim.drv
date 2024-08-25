{
  config = {
    perSystem =
      { pkgs, ... }:
      {
        neovim = {
          env = {
            JAVA_DEBUG_JAR = (pkgs.callPackage ./pkgs/java-debug { }) + "/share/java-debug/java-debug.jar";
          };
          paths = with pkgs; [
            nushell
            fd
            git
            gh
            ripgrep

            # lua
            stylua
            lua-language-server

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
            dhall-lsp-server
            helm-ls
            jq-lsp
            ltex-ls
            nodePackages.dockerfile-language-server-nodejs
            taplo
          ];

          lazy = {
            package = (pkgs.callPackage ./pkgs/plugins { }).lazy-nvim;
            settings.dev.path = "~/Code/neovim";
            plugins = import ./plugins { inherit pkgs; };
          };
        };
      };
  };
}
