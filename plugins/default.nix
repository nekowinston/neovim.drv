{ pkgs }:
let
  plugins = pkgs.callPackage ../pkgs/plugins { };
  inherit (pkgs) lib vimPlugins;
  inherit (lib.generators) mkLuaInline;
in
{
  direnv = {
    package = vimPlugins.direnv-vim;
    config = ./direnv.lua;
    lazy = false;
    priority = 10000;
  };

  plenary.package = vimPlugins.plenary-nvim;
  which-key.package = vimPlugins.which-key-nvim;
  nvim-tree = {
    package = vimPlugins.nvim-tree-lua;
    config = {
      sync_root_with_cwd = true;
      diagnostics.enable = true;
      modified.enable = true;
      renderer.indent_markers.enable = true;
    };
    keys = # lua
      ''
        { { "<C-n>", "<Cmd>NvimTreeToggle<CR>", desc = "NvimTree" } }
      '';
  };
  nvim-web-devicons = {
    package = vimPlugins.nvim-web-devicons;
    config.override_by_extension.lean = {
      icon = "∀";
      name = "Lean";
    };
  };

  nvim-treesitter = {
    event = "BufRead";
    package = pkgs.symlinkJoin {
      name = "nvim-treesitter";
      paths =
        with vimPlugins;
        [
          nvim-treesitter
          nvim-treesitter-parsers.lean
        ]
        ++ nvim-treesitter.withAllGrammars.dependencies;
    };
    config = ./nvim-treesitter.lua;
    dependencies = {
      neogen = {
        package = vimPlugins.neogen;
        config.snippet_engine = "nvim";
      };
      nvim-treesitter-context = {
        package = vimPlugins.nvim-treesitter-context;
        config = {
          enable = false;
          mode = "topline";
        };
      };
      nvim-ts-autotag = {
        package = vimPlugins.nvim-ts-autotag;
        config = true;
      };
      rainbow-delimiters.package = vimPlugins.rainbow-delimiters-nvim;
      twilight-nvim.package = vimPlugins.twilight-nvim;
    };
  };
  vim-helm = {
    package = vimPlugins.vim-helm;
    ft = "helm";
  };
  vim-applescript = {
    package = plugins.vim-applescript;
    ft = "applescript";
  };

  markdown-preview = {
    package = vimPlugins.markdown-preview-nvim;
    ft = "markdown";
  };
  vim-gnupg = {
    package = vimPlugins.vim-gnupg;
    event = "VeryLazy";
  };
  vim-table-mode = {
    package = vimPlugins.vim-table-mode;
    config = # lua
      ''
        function()
          vim.cmd([[autocmd FileType markdown let g:table_mode_corner='|']])
        end
      '';
    ft = "markdown";
  };
  typst-preview = {
    package = vimPlugins.typst-preview-nvim;
    config = true;
    ft = "typst";
  };

  resession = {
    package = vimPlugins.resession-nvim;
    lazy = false;
    config = ./resession.lua;
  };
  auto-dark-mode = {
    package = plugins.auto-dark-mode-nvim;
    config = true;
    lazy = false;
    priority = 1000;
  };
  milspec = {
    package = plugins.milspec-nvim;
    config = # lua
      ''
        function() vim.cmd.colorscheme('milspec') end
      '';
    priority = 1000;
  };

  flash = {
    package = vimPlugins.flash-nvim;
    config = true;
    keys = # lua
      ''
        {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        }
      '';
  };

  noice = {
    package = vimPlugins.noice-nvim;
    event = "VeryLazy";
    config = {
      lsp.override = {
        "vim.lsp.util.convert_input_to_markdown_lines" = true;
        "vim.lsp.util.stylize_markdown" = true;
      };
      presets = {
        long_message_to_split = true;
        lsp_doc_border = true;
      };
    };
    dependencies.nui.package = vimPlugins.nui-nvim;
  };
  bufferline = {
    package = vimPlugins.bufferline-nvim;
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
        "htmltera"
        "javascriptreact"
        "php"
        "typescriptreact"
      ];
    in
    {
      package = vimPlugins.nvim-colorizer-lua;
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

  vim-sleuth.package = vimPlugins.vim-sleuth;
  comment = {
    package = vimPlugins.comment-nvim;
    config = true;
    event = "BufRead";
  };
  indent-blankline = {
    package = vimPlugins.indent-blankline-nvim;
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
    event = "BufRead";
  };
  nvim-surround = {
    package = vimPlugins.nvim-surround;
    config = true;
    event = "BufRead";
  };
  todo-comments = {
    package = vimPlugins.todo-comments-nvim;
    config = true;
    event = "BufRead";
  };

  codecompanion = {
    package = vimPlugins.codecompanion-nvim;
    config = ./codecompanion.lua;
    cmd = [
      "CodeCompanion"
      "CodeCompanionActions"
      "CodeCompanionChat"
      "CodeCompanionCmd"
    ];
    keys = # lua
      ''
        {
          { "<leader>a", "<Cmd>CodeCompanionChat Toggle<CR>", mode = {"n", "v"}, desc = "CodeCompanion: Toggle" },
          { "ga", "<Cmd>CodeCompanionChat Add<CR>", mode = "v", desc = "CodeCompanion: Add selection" },
        }
      '';
  };
  render-markdown = rec {
    package = vimPlugins.render-markdown-nvim;
    config.file_types = ft;
    ft = [
      "markdown"
      "codecompanion"
    ];
  };

  gitsigns = {
    package = vimPlugins.gitsigns-nvim;
    config = ./gitsigns.lua;
    event = "BufRead";
    cmd = "GitSigns";
  };

  neogit = {
    package = vimPlugins.neogit;
    config.integrations.diffview = true;
    cmd = "Neogit";
    keys = # lua
      ''
        { { "<leader>ng", "<Cmd>Neogit<CR>", desc = "Neogit" } }
      '';
  };
  diffview = {
    package = vimPlugins.diffview-nvim;
    cmd = [
      "DiffviewOpen"
      "DiffviewFileHistory"
    ];
    keys = # lua
      ''
        { { "<leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "Diffview" } }
      '';
  };

  vim-dadbod = {
    package = vimPlugins.vim-dadbod;
    dependencies = {
      vim-dadbod-completion.package = vimPlugins.vim-dadbod-completion;
      vim-dadbod-ui = {
        package = vimPlugins.vim-dadbod-ui;
        config = # lua
          ''
            function()
              vim.g.db_ui_use_nerd_fonts = true
              vim.g.db_ui_use_nvim_notify = true
              vim.g.db_ui_win_position = "right"
            end
          '';
      };
    };
    cmd = [
      "DB"
      "DBUI"
    ];
  };

  lualine = {
    package = vimPlugins.lualine-nvim;
    config = ./lualine.lua;
    dependencies.nvim-navic.package = vimPlugins.nvim-navic;
  };

  lazydev = {
    package = vimPlugins.lazydev-nvim;
    ft = "lua";
    config.library = [
      {
        path = "luvit-meta/library";
        words = [ "vim%.uv" ];
      }
    ];
  };
  luvit-meta = {
    package = vimPlugins.luvit-meta;
    lazy = true;
  };
  lspconfig = {
    package = vimPlugins.nvim-lspconfig;
    config = ./lsp.lua;
    event = [
      "BufNewFile"
      "BufRead"
    ];
    dependencies = {
      blink-cmp = {
        package = vimPlugins.blink-cmp;
        config = ./blink.lua;
        dependencies.friendly-snippets.package = vimPlugins.friendly-snippets;
      };
      lspkind.package = vimPlugins.lspkind-nvim;
      ltex-extra.package = vimPlugins.ltex_extra-nvim;
      schemastore.package = vimPlugins.SchemaStore-nvim;
    };
  };
  blink-compat = {
    package = vimPlugins.blink-compat;
    lazy = true;
    config = true;
  };
  crates = {
    package = vimPlugins.crates-nvim;
    config = {
      completion = {
        cmp.enabled = true;
        crates.enabled = true;
      };
      lsp.enabled = true;
    };
    event = "BufRead Cargo.toml";
  };
  # lazy by default
  rustaceanvim = {
    package = vimPlugins.rustaceanvim;
    config = ./rustaceanvim.lua;
  };
  # lazy by default
  haskell-tools = {
    package = vimPlugins.haskell-tools-nvim;
    config = ./haskell-tools.lua;
  };
  lean-nvim = {
    package = vimPlugins.lean-nvim;
    config = ./lean.lua;
    ft = "lean";
  };
  nvim-jdtls.package = vimPlugins.nvim-jdtls;

  trouble = {
    package = vimPlugins.trouble-nvim;
    config.padding = false;
    cmd = "Trouble";
    keys = # lua
      ''
        {
          { "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
          { "<leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
          { "<leader>cs", "<Cmd>Trouble symbols toggle<CR>", desc = "Symbols (Trouble)" },
          { "<leader>cS", "<Cmd>Trouble lsp toggle<CR>", desc = "LSP references/definitions/... (Trouble)" },
          { "<leader>xL", "<Cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
          { "<leader>xQ", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
          {
            "[q",
            function()
              if require("trouble").is_open() then
                require("trouble").prev({ skip_groups = true, jump = true })
              else
                local ok, err = pcall(vim.cmd.cprev)
                if not ok then
                  vim.notify(err, vim.log.levels.ERROR)
                end
              end
            end,
            desc = "Previous Trouble/Quickfix Item",
          },
          {
            "]q",
            function()
              if require("trouble").is_open() then
                require("trouble").next({ skip_groups = true, jump = true })
              else
                local ok, err = pcall(vim.cmd.cnext)
                if not ok then
                  vim.notify(err, vim.log.levels.ERROR)
                end
              end
            end,
            desc = "Next Trouble/Quickfix Item",
          }
        }
      '';
  };

  conform = {
    package = vimPlugins.conform-nvim;
    config = ./conform.lua;
    event = "BufWritePre";
    cmd = "FormatDisable";
  };

  # required by nvim-dap and neotest
  nvim-nio = {
    package = vimPlugins.nvim-nio;
    lazy = true;
  };

  nvim-dap = {
    package = vimPlugins.nvim-dap;
    config = ./dap.lua;
    dependencies = {
      nvim-dap-virtual-text = {
        package = vimPlugins.nvim-dap-virtual-text;
        config = true;
      };
      nvim-dap-ui = {
        package = vimPlugins.nvim-dap-ui;
        config = true;
      };
    };
    lazy = true;
    cmd = "DapToggleUI";
  };

  neotest = {
    package = vimPlugins.neotest;
    dependencies = {
      neotest-deno.package = vimPlugins.neotest-go;
      neotest-go.package = vimPlugins.neotest-go;
      neotest-haskell.package = vimPlugins.neotest-haskell;
    };
    cmd = "Neotest";
  };

  telescope = {
    package = vimPlugins.telescope-nvim;
    config = ./telescope.lua;
    dependencies = {
      telescope-fzf-native.package = vimPlugins.telescope-fzf-native-nvim;
    };
    cmd = "Telescope";
    keys = # lua
      ''
        {
          { "<leader>fd", "<Cmd>Telescope find_files<CR>", desc = "Find Files" },
          { "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Live Grep" },
          { "<leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Help Tags" },
          { "<leader>fr", "<Cmd>Telescope resume<CR>", desc = "Resume last picker" },
        }
      '';
  };
  venv-selector = {
    package = plugins.venv-selector-nvim;
    config = {
      settings.options.notify_user_on_venv_activation = true;
    };
    dependencies = {
      nvim-dap-python.package = vimPlugins.nvim-dap-python;
    };
    cmd = "VenvSelect";
    ft = "python";
    keys = # lua
      ''
        { { "<leader>cv", "<Cmd>:VenvSelect<CR>", desc = "Select VirtualEnv", ft = "python" } }
      '';
  };

  spectre = {
    package = vimPlugins.nvim-spectre;
    config.default.replace.cmd = "oxi";
    cmd = "Spectre";
  };

  neorepl = {
    package = vimPlugins.neorepl-nvim;
    cmd = "Repl";
  };

  winshift = {
    package = vimPlugins.winshift-nvim;
    cmd = "WinShift";
  };

  snacks = {
    package = vimPlugins.snacks-nvim;
    config = ./snacks.lua;
  };
  zen-mode = {
    package = vimPlugins.zen-mode-nvim;
    config.plugins = {
      options.laststatus = 0;
      neovide.enabled = true;
      wezterm.enabled = mkLuaInline "vim.fn.environ().TERM_PROGRAM == 'WezTerm'";
    };
    cmd = "ZenMode";
  };
}
