{
  config = {
    perSystem = {
      inputs',
      pkgs,
      ...
    }: {
      neovim = {
        paths = with pkgs; [
          # external deps
          fd
          git
          ripgrep

          # python
          black
          isort
          nodePackages.pyright

          # lua
          stylua
          lua-language-server
          luaPackages.tl
          luaPackages.teal-language-server

          # go
          repos.nekowinston.gonvim-tools

          # webdev
          nodePackages.nodejs
          nodePackages."@astrojs/language-server"
          nodePackages."@tailwindcss/language-server"
          nodePackages.alex
          nodePackages.bash-language-server
          nodePackages.dockerfile-language-server-nodejs
          nodePackages.graphql
          nodePackages.graphql-language-service-cli
          nodePackages.intelephense
          nodePackages.typescript
          nodePackages.typescript-language-server
          nodePackages.vscode-langservers-extracted
          nodePackages.yaml-language-server

          # etc
          alejandra
          deno
          ltex-ls
          nil
          nodePackages.prettier
          proselint
          shellcheck
          shfmt
          taplo
          repos.bandithedoge.nodePackages.emmet-ls
          repos.nekowinston.helm-ls
          repos.nekowinston.jq-lsp

          # nvim-spectre
          gnused
          # alias for darwin
          (writeShellScriptBin "gsed" "exec ${gnused}/bin/sed")
        ];

        lazy = {
          settings.install.colorscheme = ["catppuccin"];
          plugins = import ./plugins {inherit pkgs;};
        };
      };
    };
  };
}
