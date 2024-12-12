{ pkgs }:
let
  plugins = pkgs.callPackage ../pkgs/plugins { };
  inherit (pkgs) lib;
  inherit (lib.generators) mkLuaInline;
in
{
  direnv = {
    package = plugins.direnv-vim;
    lazy = false;
    priority = 10000;
  };

  config = {
    src = ../config;
    lazy = false;
    priority = 1000;
  };

  plenary.package = plugins.plenary-nvim;
  which-key.package = plugins.which-key-nvim;
  nvim-tree = {
    package = plugins.nvim-tree-lua;
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
    package = plugins.nvim-web-devicons;
    lazy = true;
  };

  nvim-treesitter = {
    event = "BufRead";
    package = pkgs.symlinkJoin {
      name = "nvim-treesitter";
      paths = with pkgs.vimPlugins; [ nvim-treesitter ] ++ nvim-treesitter.withAllGrammars.dependencies;
    };
    config = ./nvim-treesitter.lua;
    dependencies = {
      neogen = {
        package = plugins.neogen;
        config = {
          snippet_engine = "luasnip";
        };
      };
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
      twilight-nvim.package = plugins.twilight-nvim;
    };
  };
  vim-helm = {
    package = plugins.vim-helm;
    event = "VeryLazy";
  };
  vim-tera = {
    package = plugins.vim-tera;
    event = "VeryLazy";
  };
  nvim-autopairs = {
    package = plugins.nvim-autopairs;
    event = "InsertEnter";
    config = # lua
      ''
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
    config = # lua
      ''
        function()
          vim.cmd([[autocmd FileType markdown let g:table_mode_corner='|']])
        end
      '';
    ft = "markdown";
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
    dev = true;
  };
  milspec = {
    package = plugins.milspec-nvim;
    config = # lua
      ''
        function() vim.cmd.colorscheme('milspec') end
      '';
    priority = 1000;
    dev = true;
  };

  flash = {
    package = plugins.flash-nvim;
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

  dressing = {
    event = "VeryLazy";
    package = plugins.dressing-nvim;
  };
  noice = {
    package = plugins.noice-nvim;
    event = "VeryLazy";
    config = {
      lsp.override = {
        "vim.lsp.util.convert_input_to_markdown_lines" = true;
        "vim.lsp.util.stylize_markdown" = true;
        "cmp.entry.get_documentation" = true;
      };
      presets = {
        long_message_to_split = true;
        lsp_doc_border = true;
      };
    };
    dependencies = {
      nui.package = plugins.nui-nvim;
      nvim-notify = {
        package = plugins.nvim-notify;
        config = ./nvim-notify.lua;
      };
    };
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
        "htmltera"
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
    event = "BufRead";
  };
  nvim-surround = {
    package = plugins.nvim-surround;
    config = true;
    event = "VeryLazy";
  };
  tagalong-vim = {
    package = plugins.tagalong-vim;
    config = # lua
      ''
        function()
          vim.g.tagalong_filetypes = {
            "astro",
            "blade",
            "ejs",
            "html",
            "htmldjango",
            "htmltera",
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

  codecompanion = {
    package = plugins.codecompanion-nvim;
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
          { "<C-a>", "<Cmd>CodeCompanionActions<CR>", mode = {"n", "v"} },
          { "<leader>a", "<Cmd>CodeCompanionChat Toggle<CR>", mode = {"n", "v"}, desc = "CodeCompanion: Toggle" },
          { "ga", "<Cmd>CodeCompanionChat Add<CR>", mode = "v", desc = "CodeCompanion: Add selection" },
        }
      '';
  };
  render-markdown-nvim = rec {
    package = plugins.render-markdown-nvim;
    config.file_types = ft;
    ft = [
      "markdown"
      "codecompanion"
    ];
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
    keys = # lua
      ''
        { { "<leader>ng", "<Cmd>Neogit<CR>", desc = "Neogit" } }
      '';
  };
  diffview = {
    package = plugins.diffview-nvim;
    cmd = [
      "DiffviewOpen"
      "DiffviewFileHistory"
    ];
    keys = # lua
      ''
        { { "<leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "Diffview" } }
      '';
  };

  wakatime = {
    enabled = # lua
      ''
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
    cmd = [
      "DB"
      "DBUI"
    ];
  };
  vim-dadbod-ui = {
    package = plugins.vim-dadbod-ui;
    config = # lua
      ''
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

  lazydev = {
    package = plugins.lazydev-nvim;
    ft = "lua";
    config.library = [
      {
        path = "luvit-meta/library";
        words = [ "vim%.uv" ];
      }
    ];
  };
  luvit-meta = {
    package = plugins.luvit-meta;
    lazy = true;
  };
  lspconfig = {
    package = plugins.nvim-lspconfig;
    config = ./lsp.lua;
    event = [
      "BufNewFile"
      "BufRead"
    ];
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
      schemastore.package = plugins.schemastore-nvim;
      typescript-tools.package = plugins.typescript-tools-nvim;
    };
  };
  # lazy by default
  rustaceanvim = {
    package = plugins.rustaceanvim;
    config = ./rustaceanvim.lua;
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
      nvim-dap-virtual-text = {
        package = plugins.nvim-dap-virtual-text;
        config = true;
      };
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
      neotest-haskell.package = plugins.neotest-haskell;
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
    keys = # lua
      ''
        {
          { "<leader>fd", "<Cmd>Telescope find_files<CR>", desc = "Find Files" },
          { "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Live Grep" },
          { "<leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Help Tags" },
          { "<leader>fp", "<Cmd>Telescope project<CR>", desc = "Project" },
          { "<leader>fs", "<Cmd>SessionManager load_session<CR>", desc = "Show Sessions" },
        }
      '';
  };
  venv-selector-nvim = {
    package = plugins.venv-selector-nvim;
    config = {
      settings.options.notify_user_on_venv_activation = true;
    };
    dependencies = {
      nvim-dap-python.package = plugins.nvim-dap-python;
    };
    cmd = "VenvSelect";
    ft = "python";
    keys = # lua
      ''
        { { "<leader>cv", "<Cmd>:VenvSelect<CR>", desc = "Select VirtualEnv", ft = "python" } }
      '';
  };

  toggleterm = {
    package = plugins.toggleterm-nvim;
    config = {
      open_mapping = "<C-t>";
      shade_terminals = false;
      direction = "float";
      float_opts = {
        border = mkLuaInline "vim.g.bc.style";
        winblend = 10;
      };
      winbar.enabled = true;
    };
    cmd = "ToggleTerm";
    keys = # lua
      ''
        { { "<C-t>", "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle Terminal" } }
      '';
  };

  spectre = {
    package = plugins.nvim-spectre;
    config.default.replace.cmd = "oxi";
    cmd = "Spectre";
  };

  neorepl = {
    package = plugins.neorepl-nvim;
    cmd = "Repl";
  };

  winshift = {
    package = plugins.winshift-nvim;
    cmd = "WinShift";
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
