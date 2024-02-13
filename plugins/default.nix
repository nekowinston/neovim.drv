{pkgs}: let
  srcs = builtins.mapAttrs (name: pkg: pkg.src) (pkgs.callPackage ../_sources/generated.nix {});
in rec {
  config = {
    src = ./config;
    lazy = false;
    priority = 1000;
  };

  plenary.src = srcs.plenary;
  which-key = {
    src = srcs.which-key;
    config = ./which-key.lua;
  };
  nvim-tree = {
    src = srcs.nvim-tree-lua;
    config = {
      sync_root_with_cwd = true;
      diagnostics.enable = true;
      renderer.indent_markers.enable = true;
      modified.enable = true;
      renderer.icons.web_devicons.folder.enable = true;
    };
    dependencies = {inherit plenary nvim-web-devicons;};
  };
  nvim-web-devicons = {
    src = srcs.nvim-web-devicons;
    config = ./nvim-web-devicons.lua;
    dependencies = {inherit catppuccin;};
  };

  nvim-treesitter = {
    package = pkgs.callPackage ../pkgs/nvim-treesitter {};
    config = ./tree-sitter.lua;
    dependencies = {
      nvim-treesitter-context = {
        src = srcs.nvim-treesitter-context;
        config = {
          enable = false;
          mode = "topline";
        };
      };
      nvim-treesitter-playground.src = srcs.playground;
      nvim-treesitter-textobjects.src = srcs.nvim-treesitter-textobjects;
      nvim-ts-autotag.src = srcs.nvim-ts-autotag;
      rainbow-delimiters.src = srcs.rainbow-delimiters;
    };
  };
  vim-helm.src = srcs.vim-helm;
  vim-just.src = srcs.vim-just;

  # markdown headers
  headlines = {
    src = srcs.headlines;
    config = true;
    dependencies = {inherit nvim-treesitter;};
  };
  markdown-preview = {
    package = pkgs.callPackage ../pkgs/markdown-preview {};
  };
  vim-gnupg.src = srcs.vim-gnupg;
  vim-table-mode = {
    src = srcs.vim-table-mode;
    config = ./vim-table-mode.lua;
  };

  dressing.src = srcs.dressing;
  glance = {
    src = srcs.glance;
    config = true;
  };

  asyncrun-vim.src = srcs.asyncrun-vim;
  asynctasks-vim.src = srcs.asynctasks-vim;

  # pure rice
  alpha = {
    src = srcs.alpha-nvim;
    config = ./alpha.lua;
    dependencies = {
      neovim-session-manager = {
        src = srcs.neovim-session-manager;
        dependencies = {inherit plenary;};
      };
    };
  };
  catppuccin = {
    src = srcs.catppuccin;
    config = ./catppuccin.lua;
    priority = 1000;
  };
  auto-dark-mode = {
    src = srcs.auto-dark-mode;
    config = true;
  };

  flash = {
    src = srcs.flash;
    config = ./flash.lua;
    # TODO: improve how neovim.nix does
    # plugin.<name>.keys = [];
    dependencies = {inherit which-key;};
  };

  fidget = {
    src = srcs.fidget;
    config = {
      text = {
        spinner = "dots";
        done = "󰗡";
        commenced = "init";
        completed = "done";
      };
      window.blend = 0;
      sources = {
        "copilot".ignore = true;
        "null-ls".ignore = true;
      };
    };
  };

  bufferline = {
    src = srcs.bufferline;
    config = ./bufferline.lua;
    dependencies = {inherit catppuccin;};
  };

  notify = {
    src = srcs.nvim-notify;
    config = ./notify.lua;
    lazy = false;
  };

  nvim-colorizer = {
    src = srcs.nvim-colorizer-lua;
    config = {
      user_default_options = {
        RGB = true;
        RRGGBB = true;
        names = false;
        RRGGBBAA = true;
        AARRGGBB = false;
        rgb_fn = false;
        hsl_fn = false;
        css = false;
        css_fn = false;
        mode = "background";
        tailwind = "both";
        sass = {enable = true;};
        virtualtext = " ";
      };
      buftypes = [
        "*"
        "!dashboard"
        "!lazy"
        "!popup"
        "!prompt"
      ];
    };
  };
  color-picker = {
    src = srcs.color-picker;
    config = true;
  };

  comment = {
    src = srcs.comment;
    config = true;
  };
  indent-blankline = {
    src = srcs.indent-blankline;
    config = ./indent-blankline.lua;
  };
  nvim-surround = {
    src = srcs.nvim-surround;
    config = true;
  };
  tagalong-vim = {
    src = srcs.tagalong-vim;
    config = ./tagalong.lua;
  };
  todo-comments = {
    src = srcs.todo-comments;
    config = true;
  };

  copilot-lua = {
    src = srcs.copilot-lua;
    config = {
      panel.enabled = false;
      suggestion = {
        enabled = true;
        auto_trigger = true;
        debounce = 75;
        keymap.accept = "<C-J>";
      };
      filetypes = {
        "." = false;
        cvs = false;
        gitcommit = false;
        gitrebase = false;
        help = false;
        hgcommit = false;
        markdown = false;
        svn = false;
        yaml = true;
      };
      copilot_node_command = "node";
      server_opts_overrides = {};
    };
  };

  # git stuff
  fugitive.src = srcs.vim-fugitive;
  gitsigns = {
    src = srcs.gitsigns;
    config = ./gitsigns.lua;
    dependencies = {inherit which-key;};
  };
  neogit = {
    src = srcs.neogit;
    config.integrations.diffview = true;
    dependencies = {inherit plenary diffview;};
  };
  diffview.src = srcs.diffview;

  presence = {
    src = srcs.presence;
    config = ./presence.lua;
  };

  wakatime.src = pkgs.vimPlugins.vim-wakatime;

  vim-dadbod.src = srcs.vim-dadbod;
  vim-dadbod-completion.src = srcs.vim-dadbod-completion;
  vim-dadbod-ui = {
    src = srcs.vim-dadbod-ui;
    # TODO: config:
    # vim.g.db_ui_use_nerd_fonts = true
    # vim.g.db_ui_win_position = "right"
  };

  lualine = {
    src = srcs.lualine;
    config = ./lualine.lua;
    dependencies = {
      navic = {
        src = srcs.nvim-navic;
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
        dependencies = {inherit nvim-web-devicons;};
      };
    };
  };

  nvim-lspconfig = {
    src = srcs.nvim-lspconfig;
    config = ./lsp.lua;
    dependencies = rec {
      cmp.src = srcs.nvim-cmp;
      cmp-buffer.src = srcs.cmp-buffer;
      cmp-cmdline.src = srcs.cmp-cmdline;
      cmp-nvim-lsp.src = srcs.cmp-nvim-lsp;
      cmp-path.src = srcs.cmp-path;
      luasnip = {
        src = srcs.luasnip;
        dependencies = {
          friendly-snippets.src = srcs.friendly-snippets;
          my-snippets.src = pkgs.callPackage ../pkgs/snippets {};
        };
      };
      cmp_luasnip.src = srcs.cmp_luasnip;
      cmp-git.src = srcs.cmp-git;
      lspkind.src = srcs.lspkind;
      null-ls.src = srcs.null-ls;
      trouble = {
        src = srcs.trouble;
        config.padding = false;
      };
      neoconf.src = srcs.neoconf;
      neodev = {
        src = srcs.neodev;
        config = true;
      };
      neorepl.src = srcs.neorepl;
      nvim-autopairs = {
        src = srcs.nvim-autopairs;
        config = ./autopairs.lua;
        dependencies = {inherit cmp;};
      };
      lsp-status.src = srcs.lsp-status;
      ltex-extra.src = srcs.ltex-extra;
      schemastore.src = srcs.schemastore;
      py_lsp.src = srcs.py_lsp;
      crates = {
        src = srcs.crates;
        config = true;
      };
      rust-tools.src = srcs.rust-tools;
      typescript-tools.src = srcs.typescript-tools;
      go-nvim = {
        src = srcs.go-nvim;
        dependencies = {
          guihua-lua.src = srcs.guihua-lua;
        };
      };
      nvim-dap = {
        src = srcs.nvim-dap;
        dependencies = {
          nvim-dap-ui.src = srcs.nvim-dap-ui;
          nvim-dap-virtual-text.src = srcs.nvim-dap-virtual-text;
        };
      };
    };
  };

  telescope = {
    src = srcs.telescope;
    config = ./telescope.lua;
    dependencies = {
      inherit plenary nvim-web-devicons;
      telescope-asynctasks.src = srcs.telescope-asynctasks;
      telescope-file-browser.src = srcs.telescope-file-browser;
      telescope-fzf-native.package = pkgs.callPackage ../pkgs/telescope-fzf-native {};
      telescope-project.src = srcs.telescope-project;
      telescope-ui-select.src = srcs.telescope-ui-select;
      octo = {
        src = srcs.octo;
        config = true;
      };
    };
  };

  toggleterm = {
    src = srcs.toggleterm;
    config = {
      open_mapping = "<C-t>";
      shade_terminals = false;
    };
  };

  spectre = {
    src = srcs.nvim-spectre;
    config.replace_engine.sed.cmd = "sed";
    dependencies = {inherit plenary;};
  };

  neorg = {
    src = srcs.neorg;
    config = {
      load = {
        "core.defaults" = {};
        "core.concealer" = {};
        "core.dirman" = {
          config = {
            workspaces = {
              notes = "~/notes";
            };
          };
        };
      };
    };
    dependencies = {inherit plenary;};
  };

  direnv.src = srcs.direnv-vim;

  copilotchat = {
    src = srcs.copilotchat;
    config = true;
  };
}
