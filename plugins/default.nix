# FIXME: All occurrances of `<space>` should be `<leader>`, but this requires
# injection in `before.lua` via neovim.nix

{ pkgs }:
let
  plugins = pkgs.callPackage ../pkgs/plugins { };
  inherit (pkgs) lib;
  inherit (lib.generators) mkLuaInline;
in
{
  config = {
    src = ../config;
    lazy = false;
    priority = 1000;
  };

  plenary.package = plugins.plenary-nvim;
  which-key = {
    package = plugins.which-key-nvim;
    config = {
      key_labels = {
        "<space>" = "󱁐 ";
        "<leader>" = "󱁐 ";
        "<bs>" = "󰌍 ";
        "<cr>" = "󰌑 ";
        "<esc>" = "󱊷 ";
        "<tab>" = "󰌒 ";
      };
      window = {
        # FIXME: sort out the load order for `config` so that `vim.g` is 
        # available here:
        # border = mkLuaInline "vim.g.bc.style";
        margin = [
          0
          0
          0
          0
        ];
      };
    };
  };
  nvim-tree = {
    package = plugins.nvim-tree-lua;
    config = {
      sync_root_with_cwd = true;
      diagnostics.enable = true;
      modified.enable = true;
      renderer.indent_markers.enable = true;
    };
    keys = ''
      { { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" } }
    '';
  };
  nvim-web-devicons = {
    package = plugins.nvim-web-devicons;
    lazy = true;
  };

  nvim-treesitter = {
    event = "BufRead";
    package = pkgs.vimPlugins.nvim-treesitter.override {
      grammars = [
        "arduino"
        "astro"
        "awk"
        "bash"
        "blade"
        "c"
        "cpp"
        "css"
        "csv"
        "d"
        "dhall"
        "diff"
        "dockerfile"
        "git_config"
        "git_rebase"
        "gitattributes"
        "gitcommit"
        "gitignore"
        "go"
        "gomod"
        "gosum"
        "gpg"
        "graphql"
        "groovy"
        "haskell"
        "hlsl"
        "html"
        "java"
        "javascript"
        "jsdoc"
        "json"
        "jsonc"
        "just"
        "kdl"
        "lua"
        "make"
        "markdown"
        "markdown_inline"
        "nix"
        "nu"
        "objc"
        "php"
        "php_only"
        "pug"
        "python"
        "rust"
        "scss"
        "svelte"
        "tsv"
        "tsx"
        "typescript"
        "vim"
        "vimdoc"
        "vue"
        "yaml"
        "zig"
      ];
    };
    config = ./nvim-treesitter.lua;
    dependencies = {
      nvim-treesitter-context = {
        package = plugins.nvim-treesitter-context;
        config = {
          enable = false;
          mode = "topline";
        };
      };
      nvim-treesitter-textobjects.package = plugins.nvim-treesitter-textobjects;
      nvim-ts-autotag.package = plugins.nvim-ts-autotag;
      rainbow-delimiters.package = plugins.rainbow-delimiters;
    };
  };
  vim-helm = {
    package = plugins.vim-helm;
    event = "VeryLazy";
  };
  nvim-autopairs = {
    package = plugins.nvim-autopairs;
    event = "InsertEnter";
    config = ''
      function()
      	require("nvim-autopairs").setup()

      	local cmp = require("cmp")
      	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    '';
  };
  vim-applescript = {
    package = plugins.vim-applescript;
    ft = "applescript";
  };

  markdown-preview = {
    package = pkgs.vimPlugins.markdown-preview-nvim;
    ft = "markdown";
  };
  vim-gnupg = {
    package = plugins.vim-gnupg;
    event = "VeryLazy";
  };
  vim-table-mode = {
    package = plugins.vim-table-mode;
    config = ''
      function()
        vim.cmd([[autocmd FileType markdown let g:table_mode_corner='|']])
      end
    '';
    ft = "markdown";
  };

  alpha = {
    package = plugins.alpha-nvim;
    config = ./alpha.lua;
  };
  neovim-session-manager = {
    package = plugins.neovim-session-manager;
    main = "session_manager";
    config = # lua
      ''
        function()
          local config = require('session_manager.config')
          require('session_manager').setup({
            autoload_mode = {
              config.AutoloadMode.GitSession,
              config.AutoloadMode.CurrentDir
            }
          })
        end
      '';
  };
  auto-dark-mode = {
    package = plugins.auto-dark-mode-nvim;
    config = true;
    lazy = false;
    priority = 1000;
  };
  milspec = {
    package = plugins.milspec-nvim;
    config = "function() vim.cmd.colorscheme('milspec') end";
    lazy = false;
    priority = 1000;
  };

  flash = {
    package = plugins.flash-nvim;
    config = true;
    keys = ''
      {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      }
    '';
  };

  dressing = {
    package = plugins.dressing-nvim;
    event = "VeryLazy";
  };
  fidget = {
    package = plugins.fidget-nvim;
    config = {
      progress = {
        ignore = [ "copilot" ];
        display.done_icon = "󰗡";
      };
      notification = {
        override_vim_notify = true;
        window.winblend = 30;
      };
    };
    event = "VeryLazy";
  };

  bufferline = {
    package = plugins.bufferline-nvim;
    config = ./bufferline.lua;
    event = "VeryLazy";
  };

  nvim-colorizer =
    let
      filetypes = [
        "astro"
        "blade"
        "css"
        "html"
        "html"
        "htmldjango"
        "javascriptreact"
        "php"
        "typescriptreact"
      ];
    in
    {
      package = plugins.nvim-colorizer-lua;
      config = {
        filetypes = filetypes;
        user_default_options = {
          css = true;
          sass.enable = true;
          RRGGBBAA = true;
          AARRGGBB = true;
          mode = "background";
          tailwind = "both";
        };
        buftypes = [
          "*"
          "!dashboard"
          "!lazy"
          "!popup"
          "!prompt"
        ];
      };
      ft = filetypes;
      cmd = "ColorizerToggle";
    };
  color-picker = {
    package = plugins.color-picker-nvim;
    config = true;
    event = "VeryLazy";
  };

  comment = {
    package = plugins.comment-nvim;
    config = true;
    event = "VeryLazy";
  };
  indent-blankline = {
    package = plugins.indent-blankline-nvim;
    main = "ibl";
    config.exclude.filetypes = [
      "alpha"
      "fugitive"
      "help"
      "lazy"
      "NeogitCommitView"
      "NeogitConsole"
      "NeogitStatus"
      "NvimTree"
      "TelescopePrompt"
      "Trouble"
    ];
    event = "VeryLazy";
  };
  nvim-surround = {
    package = plugins.nvim-surround;
    config = true;
    event = "VeryLazy";
  };
  tagalong-vim = {
    package = plugins.tagalong-vim;
    config = ''
      function()
        vim.g.tagalong_filetypes = {
          "astro",
          "blade",
          "ejs",
          "html",
          "htmldjango",
          "javascriptreact",
          "php",
          "typescriptreact",
          "xml",
        }
      end
    '';
    ft = [
      "astro"
      "blade"
      "ejs"
      "html"
      "htmldjango"
      "javascriptreact"
      "php"
      "typescriptreact"
      "xml"
    ];
  };
  todo-comments = {
    package = plugins.todo-comments-nvim;
    config = true;
    event = "VeryLazy";
  };

  copilot = {
    package = plugins.copilot-lua;
    config = {
      panel.enabled = false;
      suggestion = {
        enabled = true;
        auto_trigger = true;
        debounce = 75;
        keymap.accept = "<C-J>";
      };
      filetypes = {
        gitcommit = true;
        markdown = true;
        yaml = true;
      };
    };
    cmd = "Copilot";
    event = "InsertEnter";
  };

  gitsigns = {
    package = plugins.gitsigns-nvim;
    config = ./gitsigns.lua;
    event = "VeryLazy";
  };

  neogit = {
    package = plugins.neogit;
    config.integrations.diffview = true;
    cmd = "Neogit";
    keys = ''
      { { "<space>ng", "<cmd>Neogit<cr>", desc = "Neogit" } }
    '';
  };
  diffview = {
    package = plugins.diffview-nvim;
    cmd = [
      "DiffviewOpen"
      "DiffviewFileHistory"
    ];
    keys = ''
      { { "<space>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview" } }
    '';
  };

  # presence = {
  #   package = plugins.presence-nvim;
  #   config = ./presence.lua;
  #   event = "VeryLazy";
  # };

  wakatime = {
    enabled = ''
      function()
        return vim.fn.glob("~/.wakatime.cfg") ~= "" or vim.fn.glob("$WAKATIME_HOME/.wakatime.cfg") ~= ""
      end
    '';
    package = pkgs.vimPlugins.vim-wakatime;
    paths = [ pkgs.wakatime ];
    event = "VeryLazy";
  };

  vim-dadbod = {
    package = plugins.vim-dadbod;
    event = "VeryLazy";
    cmd = "DB";
  };
  vim-dadbod-completion = {
    package = plugins.vim-dadbod-completion;
    event = "VeryLazy";
  };
  vim-dadbod-ui = {
    package = plugins.vim-dadbod-ui;
    config = ''
      function()
        vim.g.db_ui_use_nerd_fonts = true
        vim.g.db_ui_use_nvim_notify = true
        vim.g.db_ui_win_position = "right"
      end
    '';
    cmd = "DBUI";
  };

  lualine = {
    package = plugins.lualine-nvim;
    config = {
      options = {
        icons_enabled = true;
        theme = "milspec";
        disabled_filetypes =
          let
            ft = [ "alpha" ];
          in
          {
            statusline = ft;
            winbar = ft;
          };
        component_separators = {
          left = "";
          right = "";
        };
        section_separators = {
          left = "";
          right = "";
        };
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [
          "branch"
          "diff"
          "diagnostics"
        ];
        lualine_c = [ "searchcount" ];
        lualine_x = [ "filetype" ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
      winbar.lualine_c = [ (mkLuaInline "{ 'navic', draw_empty = true }") ];
    };
    dependencies = {
      navic = {
        package = plugins.nvim-navic;
        config = {
          highlight = true;
          separator = " ";
          icons = {
            File = " ";
            Module = " ";
            Namespace = " ";
            Package = " ";
            Class = " ";
            Method = " ";
            Property = " ";
            Field = " ";
            Constructor = " ";
            Enum = " ";
            Interface = " ";
            Function = " ";
            Variable = " ";
            Constant = " ";
            String = " ";
            Number = " ";
            Boolean = " ";
            Array = " ";
            Object = " ";
            Key = " ";
            Null = " ";
            EnumMember = " ";
            Struct = " ";
            Event = " ";
            Operator = " ";
            TypeParameter = " ";
          };
        };
      };
    };
  };

  neoconf = {
    package = plugins.neoconf-nvim;
    config = true;
    priority = 100; # make sure this loads before `lspconfig`.
  };
  lspconfig = {
    package = plugins.nvim-lspconfig;
    config = ./lsp.lua;
    event = "BufRead";
    dependencies = {
      cmp.package = plugins.nvim-cmp;
      cmp-buffer.package = plugins.cmp-buffer;
      cmp-cmdline.package = plugins.cmp-cmdline;
      cmp-git.package = plugins.cmp-git;
      cmp-nvim-lsp.package = plugins.cmp-nvim-lsp;
      cmp-path.package = plugins.cmp-path;
      cmp_luasnip.package = plugins.cmp_luasnip;
      friendly-snippets.package = plugins.friendly-snippets;
      lspkind.package = plugins.lspkind-nvim;
      ltex-extra.package = plugins.ltex-extra-nvim;
      luasnip.package = plugins.luasnip;
      neodev = {
        package = plugins.neodev-nvim;
        config = true;
      };
      schemastore.package = plugins.schemastore-nvim;
      typescript-tools.package = plugins.typescript-tools-nvim;
    };
  };
  py_lsp = {
    package = plugins.py_lsp-nvim;
    config.host_python = lib.getExe pkgs.python3;
    event = "BufRead *.py";
    cmd = "PyLspCreateVenv";
  };
  # lazy by default
  rustaceanvim = {
    package = plugins.rustaceanvim;
    config = # lua
      ''
        function()
          vim.g.rustaceanvim = {
            tools = {
              float_win_config = {
                -- FIXME: this should use `vim.g.bc.style`
                border = "rounded"
              }
            }
          }
        end
      '';
  };
  # lazy by default
  haskell-tools = {
    package = plugins.haskell-tools-nvim;
    config = # lua
      ''
        function()
          vim.g.haskell_tools = {}
        end
      '';
  };
  nvim-jdtls.package = plugins.nvim-jdtls;

  crates = {
    package = plugins.crates-nvim;
    config = true;
    event = "BufRead Cargo.toml";
  };

  trouble = {
    package = plugins.trouble-nvim;
    config.padding = false;
    cmd = "Trouble";
  };

  conform = {
    package = plugins.conform-nvim;
    config = ./conform.lua;
    event = "BufWritePre";
    cmd = "FormatDisable";
  };

  # required by nvim-dap and neotest
  nvim-nio = {
    package = plugins.nvim-nio;
    lazy = true;
  };

  nvim-dap = {
    package = plugins.nvim-dap;
    config = ./dap.lua;
    dependencies = {
      nvim-dap-virtual-text.package = plugins.nvim-dap-virtual-text;
      nvim-dap-ui = {
        package = plugins.nvim-dap-ui;
        config = true;
      };
    };
    lazy = true;
    cmd = "DapToggleUI";
  };

  neotest = {
    package = plugins.neotest;
    dependencies = {
      neotest-deno.package = plugins.neotest-go;
      neotest-go.package = plugins.neotest-go;
    };
    cmd = "Neotest";
  };

  telescope = {
    package = plugins.telescope-nvim;
    config = ./telescope.lua;
    dependencies = {
      telescope-file-browser.package = plugins.telescope-file-browser-nvim;
      telescope-fzf-native.package = pkgs.vimPlugins.telescope-fzf-native-nvim;
      telescope-project.package = plugins.telescope-project-nvim;
    };
    cmd = "Telescope";
    keys = ''
      {
        { "<space>fd", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<space>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<space>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
        { "<space>fp", "<cmd>Telescope project<cr>", desc = "Project" },
        { "<space>fs", "<cmd>SessionManager load_session<cr>", desc = "Show Sessions" },
      }
    '';
  };
  octo = {
    package = plugins.octo-nvim;
    config = true;
    cmd = "Octo";
  };

  toggleterm = {
    package = plugins.toggleterm-nvim;
    config = {
      open_mapping = "<C-t>";
      shade_terminals = false;
      direction = "float";
      float_opts = {
        # FIXME: this should use `vim.g.bc.style`
        border = "rounded";
        winblend = 10;
      };
      winbar.enabled = true;
    };
    cmd = "ToggleTerm";
    keys = ''
      { { "<C-t>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Terminal" } }
    '';
  };

  spectre = {
    package = plugins.nvim-spectre;
    config.default.replace.cmd = "oxi";
    cmd = "Spectre";
  };

  direnv = {
    package = plugins.direnv-vim;
    event = "VeryLazy";
  };

  neorepl = {
    package = plugins.neorepl-nvim;
    cmd = "Repl";
  };

  zen-mode-nvim = {
    package = plugins.zen-mode-nvim;
    config.plugins = {
      options.laststatus = 0;
      wezterm.enabled = true;
    };
    cmd = "ZenMode";
  };
}
