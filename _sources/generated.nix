# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alpha-nvim = {
    pname = "alpha-nvim";
    version = "41283fb402713fc8b327e60907f74e46166f4cfd";
    src = fetchFromGitHub {
      owner = "goolord";
      repo = "alpha-nvim";
      rev = "41283fb402713fc8b327e60907f74e46166f4cfd";
      fetchSubmodules = false;
      sha256 = "sha256-kTVPKZ/e1us/uHfSwFwR38lFYN8EotJq2jKz6xm/eqg=";
    };
    date = "2024-02-25";
  };
  auto-dark-mode-nvim = {
    pname = "auto-dark-mode-nvim";
    version = "2b8c938da9a7c9432120266b92936b2c22e8cfb8";
    src = fetchFromGitHub {
      owner = "f-person";
      repo = "auto-dark-mode.nvim";
      rev = "2b8c938da9a7c9432120266b92936b2c22e8cfb8";
      fetchSubmodules = false;
      sha256 = "sha256-ZRaJbIuQJmh6MoWjRwNK8n0dmd5Cv/BoXGovNhggcnQ=";
    };
    date = "2024-05-18";
  };
  bufferline-nvim = {
    pname = "bufferline-nvim";
    version = "aa16dafdc642594c7ade7e88d31a6119feb189d6";
    src = fetchFromGitHub {
      owner = "akinsho";
      repo = "bufferline.nvim";
      rev = "aa16dafdc642594c7ade7e88d31a6119feb189d6";
      fetchSubmodules = false;
      sha256 = "sha256-Nu7jx2zWVLEhbqtGSThfQCN2EfhHYlNFcbbdS8sUx2s=";
    };
    date = "2024-07-10";
  };
  cmp-buffer = {
    pname = "cmp-buffer";
    version = "3022dbc9166796b644a841a02de8dd1cc1d311fa";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-buffer";
      rev = "3022dbc9166796b644a841a02de8dd1cc1d311fa";
      fetchSubmodules = false;
      sha256 = "sha256-dG4U7MtnXThoa/PD+qFtCt76MQ14V1wX8GMYcvxEnbM=";
    };
    date = "2022-08-10";
  };
  cmp-cmdline = {
    pname = "cmp-cmdline";
    version = "d250c63aa13ead745e3a40f61fdd3470efde3923";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-cmdline";
      rev = "d250c63aa13ead745e3a40f61fdd3470efde3923";
      fetchSubmodules = false;
      sha256 = "sha256-iBmXp+gUSMbgfkv7c7RDQAwPq02e07wEnBETP0dWBOo=";
    };
    date = "2024-03-22";
  };
  cmp-git = {
    pname = "cmp-git";
    version = "22116bdffbe68bfc6ca05d52e9f217587cbfea8b";
    src = fetchFromGitHub {
      owner = "petertriho";
      repo = "cmp-git";
      rev = "22116bdffbe68bfc6ca05d52e9f217587cbfea8b";
      fetchSubmodules = false;
      sha256 = "sha256-zbQjrRGU4p6lkMJgF26sp6JZAz7xD4Zp8c/A73oFvP4=";
    };
    date = "2024-07-13";
  };
  cmp-nvim-lsp = {
    pname = "cmp-nvim-lsp";
    version = "39e2eda76828d88b773cc27a3f61d2ad782c922d";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp";
      rev = "39e2eda76828d88b773cc27a3f61d2ad782c922d";
      fetchSubmodules = false;
      sha256 = "sha256-CT1+Z4XJBVsl/RqvJeGmyitD6x7So0ylXvvef5jh7I8=";
    };
    date = "2024-05-17";
  };
  cmp-path = {
    pname = "cmp-path";
    version = "91ff86cd9c29299a64f968ebb45846c485725f23";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-path";
      rev = "91ff86cd9c29299a64f968ebb45846c485725f23";
      fetchSubmodules = false;
      sha256 = "sha256-thppiiV3wjIaZnAXmsh7j3DUc6ceSCvGzviwFUnoPaI=";
    };
    date = "2022-10-03";
  };
  cmp_luasnip = {
    pname = "cmp_luasnip";
    version = "05a9ab28b53f71d1aece421ef32fee2cb857a843";
    src = fetchFromGitHub {
      owner = "saadparwaiz1";
      repo = "cmp_luasnip";
      rev = "05a9ab28b53f71d1aece421ef32fee2cb857a843";
      fetchSubmodules = false;
      sha256 = "sha256-nUJJl2zyK/oSwz5RzI9j3gf9zpDfCImCYbPbVsyXgz8=";
    };
    date = "2023-10-09";
  };
  color-picker-nvim = {
    pname = "color-picker-nvim";
    version = "06cb5f853535dea529a523e9a0e8884cdf9eba4d";
    src = fetchFromGitHub {
      owner = "ziontee113";
      repo = "color-picker.nvim";
      rev = "06cb5f853535dea529a523e9a0e8884cdf9eba4d";
      fetchSubmodules = false;
      sha256 = "sha256-a1hpKKvBG8ey/+gbfFEK8CPawEK9EdcQbnIfi7X0C9I=";
    };
    date = "2023-05-21";
  };
  comment-nvim = {
    pname = "comment-nvim";
    version = "e30b7f2008e52442154b66f7c519bfd2f1e32acb";
    src = fetchFromGitHub {
      owner = "numtostr";
      repo = "comment.nvim";
      rev = "e30b7f2008e52442154b66f7c519bfd2f1e32acb";
      fetchSubmodules = false;
      sha256 = "sha256-h0kPue5Eqd5aeu4VoLH45pF0DmWWo1d8SnLICSQ63zc=";
    };
    date = "2024-06-09";
  };
  conform-nvim = {
    pname = "conform-nvim";
    version = "310e2e95a4f832163f3f7a9fedebb1a4afc0db69";
    src = fetchFromGitHub {
      owner = "stevearc";
      repo = "conform.nvim";
      rev = "310e2e95a4f832163f3f7a9fedebb1a4afc0db69";
      fetchSubmodules = false;
      sha256 = "sha256-me8cd2ugluHHXDYjhe5kDrB/E7HSITB9JWrcA1zCfv0=";
    };
    date = "2024-07-16";
  };
  copilot-lua = {
    pname = "copilot-lua";
    version = "86537b286f18783f8b67bccd78a4ef4345679625";
    src = fetchFromGitHub {
      owner = "zbirenbaum";
      repo = "copilot.lua";
      rev = "86537b286f18783f8b67bccd78a4ef4345679625";
      fetchSubmodules = false;
      sha256 = "sha256-HC1QZlqEg+RBz/8kjLadafc06UoMAjhh0UO/BWQGMY8=";
    };
    date = "2024-06-14";
  };
  crates-nvim = {
    pname = "crates-nvim";
    version = "c3fd47391de6999f4c939af89494d08443f71916";
    src = fetchFromGitHub {
      owner = "saecki";
      repo = "crates.nvim";
      rev = "c3fd47391de6999f4c939af89494d08443f71916";
      fetchSubmodules = false;
      sha256 = "sha256-y1NLR4w7kGVJO5gGSguQB5BpDYrUgyPz/4Tf01c9hG8=";
    };
    date = "2024-07-01";
  };
  diffview-nvim = {
    pname = "diffview-nvim";
    version = "4516612fe98ff56ae0415a259ff6361a89419b0a";
    src = fetchFromGitHub {
      owner = "sindrets";
      repo = "diffview.nvim";
      rev = "4516612fe98ff56ae0415a259ff6361a89419b0a";
      fetchSubmodules = false;
      sha256 = "sha256-SX+ybIzL/w6uyCy4iZKnWnzTFwqB1oXSgyYVAdpdKi8=";
    };
    date = "2024-06-13";
  };
  direnv-vim = {
    pname = "direnv-vim";
    version = "ab2a7e08dd630060cd81d7946739ac7442a4f269";
    src = fetchFromGitHub {
      owner = "direnv";
      repo = "direnv.vim";
      rev = "ab2a7e08dd630060cd81d7946739ac7442a4f269";
      fetchSubmodules = false;
      sha256 = "sha256-Lwwm95UEkS8Q0Qsoh10o3sFn48wf7v7eCX/FJJV1HMI=";
    };
    date = "2023-12-02";
  };
  dressing-nvim = {
    pname = "dressing-nvim";
    version = "6741f1062d3dc6e4755367a7e9b347b553623f04";
    src = fetchFromGitHub {
      owner = "stevearc";
      repo = "dressing.nvim";
      rev = "6741f1062d3dc6e4755367a7e9b347b553623f04";
      fetchSubmodules = false;
      sha256 = "sha256-LlcE/1/IT6QW/o5gks80BFnrIdBd4GjW4M9o+84/j1c=";
    };
    date = "2024-06-18";
  };
  fidget-nvim = {
    pname = "fidget-nvim";
    version = "d855eed8a06531a7e8fd0684889b2943f373c469";
    src = fetchFromGitHub {
      owner = "j-hui";
      repo = "fidget.nvim";
      rev = "d855eed8a06531a7e8fd0684889b2943f373c469";
      fetchSubmodules = false;
      sha256 = "sha256-fjxdRN08BMU7jTWdhdzh8kW18ZURS9SJCwnTxuz6aFE=";
    };
    date = "2024-07-13";
  };
  flash-nvim = {
    pname = "flash-nvim";
    version = "25ba3f4d1e0b080213b39518ebcfbb693a23c957";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "flash.nvim";
      rev = "25ba3f4d1e0b080213b39518ebcfbb693a23c957";
      fetchSubmodules = false;
      sha256 = "sha256-7U6cjklwMVqDDgCgcwPC2n6bqsYuv5qhbGSPLPvvHyM=";
    };
    date = "2024-07-15";
  };
  friendly-snippets = {
    pname = "friendly-snippets";
    version = "00ebcaa159e817150bd83bfe2d51fa3b3377d5c4";
    src = fetchFromGitHub {
      owner = "rafamadriz";
      repo = "friendly-snippets";
      rev = "00ebcaa159e817150bd83bfe2d51fa3b3377d5c4";
      fetchSubmodules = false;
      sha256 = "sha256-kwGyfXZ+jZ3PIniESUGBltBm2fRXV5ArNhSo+zosdco=";
    };
    date = "2024-07-14";
  };
  gitsigns-nvim = {
    pname = "gitsigns-nvim";
    version = "f4928ba14eb6c667786ac7d69927f6aee6719f1e";
    src = fetchFromGitHub {
      owner = "lewis6991";
      repo = "gitsigns.nvim";
      rev = "f4928ba14eb6c667786ac7d69927f6aee6719f1e";
      fetchSubmodules = false;
      sha256 = "sha256-iFVTd7nO4twq/S3qQpy4PZfHMpLDErJfJk63TmwL8t0=";
    };
    date = "2024-07-16";
  };
  haskell-tools-nvim = {
    pname = "haskell-tools-nvim";
    version = "b003e20e99aa79bfec7c632e5ab817e1c10c8036";
    src = fetchFromGitHub {
      owner = "mrcjkb";
      repo = "haskell-tools.nvim";
      rev = "b003e20e99aa79bfec7c632e5ab817e1c10c8036";
      fetchSubmodules = false;
      sha256 = "sha256-YFBUQ2UFVPx17RebrbgF+ld6PYwsgsWWObhbY5zF8qE=";
    };
    date = "2024-07-14";
  };
  indent-blankline-nvim = {
    pname = "indent-blankline-nvim";
    version = "65e20ab94a26d0e14acac5049b8641336819dfc7";
    src = fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "indent-blankline.nvim";
      rev = "65e20ab94a26d0e14acac5049b8641336819dfc7";
      fetchSubmodules = false;
      sha256 = "sha256-PSsXBB2KOFPJJ1O8fpTvsVe2A0/wU6Ae9dN/UemraZM=";
    };
    date = "2024-06-28";
  };
  lazy-nvim = {
    pname = "lazy-nvim";
    version = "d731a6b005fd239e85e555bd57362382f6c1e461";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "lazy.nvim";
      rev = "d731a6b005fd239e85e555bd57362382f6c1e461";
      fetchSubmodules = false;
      sha256 = "sha256-delPoMoxIe/g7Aidj9JWnDYwOy5MFcG/sRgZjryxWmw=";
    };
    date = "2024-07-16";
  };
  lspkind-nvim = {
    pname = "lspkind-nvim";
    version = "1735dd5a5054c1fb7feaf8e8658dbab925f4f0cf";
    src = fetchFromGitHub {
      owner = "onsails";
      repo = "lspkind.nvim";
      rev = "1735dd5a5054c1fb7feaf8e8658dbab925f4f0cf";
      fetchSubmodules = false;
      sha256 = "sha256-/QLdBU/Zwmkw1NGuLBD48tvrmIP9d9WHhgcLEQgRTWo=";
    };
    date = "2024-01-11";
  };
  ltex-extra-nvim = {
    pname = "ltex-extra-nvim";
    version = "24acd044ce7a26b3cdb537cbd094de37c3e1ac45";
    src = fetchFromGitHub {
      owner = "barreiroleo";
      repo = "ltex-extra.nvim";
      rev = "24acd044ce7a26b3cdb537cbd094de37c3e1ac45";
      fetchSubmodules = false;
      sha256 = "sha256-OGeeEIF+z03DdJO2d2kzQ0lZnIYLabp6irYPqYgbCbc=";
    };
    date = "2024-06-15";
  };
  lualine-nvim = {
    pname = "lualine-nvim";
    version = "544dd1583f9bb27b393f598475c89809c4d5e86b";
    src = fetchFromGitHub {
      owner = "nvim-lualine";
      repo = "lualine.nvim";
      rev = "544dd1583f9bb27b393f598475c89809c4d5e86b";
      fetchSubmodules = false;
      sha256 = "sha256-uNDRynWs7fXDDzDFKvE31oDetv3aabiJfr/r/84z9Sg=";
    };
    date = "2024-07-15";
  };
  luasnip = {
    pname = "luasnip";
    version = "ce0a05ab4e2839e1c48d072c5236cce846a387bc";
    src = fetchFromGitHub {
      owner = "L3MON4D3";
      repo = "LuaSnip";
      rev = "ce0a05ab4e2839e1c48d072c5236cce846a387bc";
      fetchSubmodules = false;
      sha256 = "sha256-zjefbPMiKxwYsBzE75jQRVNFMDSnCq1hKe1cBBqMRWg=";
    };
    date = "2024-06-28";
  };
  milspec-nvim = {
    pname = "milspec-nvim";
    version = "3988464c4514e441b4f81599507bdf2815b2f9e2";
    src = fetchFromGitHub {
      owner = "nekowinston";
      repo = "milspec.nvim";
      rev = "3988464c4514e441b4f81599507bdf2815b2f9e2";
      fetchSubmodules = false;
      sha256 = "sha256-2U8yqLqTnal0CAZOD8bWrv/bprl7Tusg1H5gnasbfVY=";
    };
    date = "2024-06-08";
  };
  neoconf-nvim = {
    pname = "neoconf-nvim";
    version = "c282e6c6f5652e796f878f81b196245f03b98144";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "neoconf.nvim";
      rev = "c282e6c6f5652e796f878f81b196245f03b98144";
      fetchSubmodules = false;
      sha256 = "sha256-xLBUpEKkRZnrWBRPIR+BMy7riTaCAJNj3KAuZLRP9b8=";
    };
    date = "2024-07-17";
  };
  neodev-nvim = {
    pname = "neodev-nvim";
    version = "46aa467dca16cf3dfe27098042402066d2ae242d";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "neodev.nvim";
      rev = "46aa467dca16cf3dfe27098042402066d2ae242d";
      fetchSubmodules = false;
      sha256 = "sha256-hOjzlo/IqmV8tYjGwfmcCPEmHYsWnEIwtHZdhpwA1kM=";
    };
    date = "2024-07-06";
  };
  neogit = {
    pname = "neogit";
    version = "100959d839dfb64e16df27de79af2087e098ebaa";
    src = fetchFromGitHub {
      owner = "NeogitOrg";
      repo = "neogit";
      rev = "100959d839dfb64e16df27de79af2087e098ebaa";
      fetchSubmodules = false;
      sha256 = "sha256-8coCJi1I3uqsfYcMXlSBcUcu35oIWMYMuFGhISZUWiQ=";
    };
    date = "2024-07-16";
  };
  neorepl-nvim = {
    pname = "neorepl-nvim";
    version = "15f4c4e523e1fbec74766e1967e1c2491df013c9";
    src = fetchFromGitHub {
      owner = "ii14";
      repo = "neorepl.nvim";
      rev = "15f4c4e523e1fbec74766e1967e1c2491df013c9";
      fetchSubmodules = false;
      sha256 = "sha256-PBEZDbwH1ZYAh9y2XXavbKo1SzlzO66J4e03gOh+Pwc=";
    };
    date = "2024-06-02";
  };
  neotest = {
    pname = "neotest";
    version = "32ff2ac21135a372a42b38ae131e531e64833bd3";
    src = fetchFromGitHub {
      owner = "nvim-neotest";
      repo = "neotest";
      rev = "32ff2ac21135a372a42b38ae131e531e64833bd3";
      fetchSubmodules = false;
      sha256 = "sha256-RATwN2sV/YI7q+bZl15DMgKWnDTTORinQ+Rl2NT/nJA=";
    };
    date = "2024-07-13";
  };
  neotest-deno = {
    pname = "neotest-deno";
    version = "7136b9342aeecb675c7c16a0bde327d7fcb00a1c";
    src = fetchFromGitHub {
      owner = "MarkEmmons";
      repo = "neotest-deno";
      rev = "7136b9342aeecb675c7c16a0bde327d7fcb00a1c";
      fetchSubmodules = false;
      sha256 = "sha256-jEksgs7BDNsi8pKeZ6wEDA+pytT9oSKWbs4d0s30PuM=";
    };
    date = "2022-12-09";
  };
  neotest-go = {
    pname = "neotest-go";
    version = "92950ad7be2ca02a41abca5c6600ff6ffaf5b5d6";
    src = fetchFromGitHub {
      owner = "nvim-neotest";
      repo = "neotest-go";
      rev = "92950ad7be2ca02a41abca5c6600ff6ffaf5b5d6";
      fetchSubmodules = false;
      sha256 = "sha256-BEq6hX7TbGQV899kgzrFnSNrPUUXiPudyFrKb8COvXI=";
    };
    date = "2024-05-19";
  };
  neovim-session-manager = {
    pname = "neovim-session-manager";
    version = "35c154a4b904cbe2aa7acce00a8c1c54a8831780";
    src = fetchFromGitHub {
      owner = "Shatur";
      repo = "neovim-session-manager";
      rev = "35c154a4b904cbe2aa7acce00a8c1c54a8831780";
      fetchSubmodules = false;
      sha256 = "sha256-RVQf0swrX9SQz7KeuOpWkmBdZwIrVbc112ZXqkElxew=";
    };
    date = "2024-07-15";
  };
  nvim-autopairs = {
    pname = "nvim-autopairs";
    version = "78a4507bb9ffc9b00f11ae0ac48243d00cb9194d";
    src = fetchFromGitHub {
      owner = "windwp";
      repo = "nvim-autopairs";
      rev = "78a4507bb9ffc9b00f11ae0ac48243d00cb9194d";
      fetchSubmodules = false;
      sha256 = "sha256-L19WTFP6m2xfYgzafIkxS5GdweB4CvCShFrDRAgNs7k=";
    };
    date = "2024-07-07";
  };
  nvim-cmp = {
    pname = "nvim-cmp";
    version = "d818fd0624205b34e14888358037fb6f5dc51234";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "d818fd0624205b34e14888358037fb6f5dc51234";
      fetchSubmodules = false;
      sha256 = "sha256-jc4fQBaAuL4XhHljVU3sdaEyQCnHbI+gwNOTnGHk0qM=";
    };
    date = "2024-07-16";
  };
  nvim-colorizer-lua = {
    pname = "nvim-colorizer-lua";
    version = "08bd34bf0ed79723f62764c7f9ca70516d461d0d";
    src = fetchFromGitHub {
      owner = "nvchad";
      repo = "nvim-colorizer.lua";
      rev = "08bd34bf0ed79723f62764c7f9ca70516d461d0d";
      fetchSubmodules = false;
      sha256 = "sha256-3cyf0YFNWuSsrKlFbxoE4vl0t8q4ra85rlxpaqu9UIc=";
    };
    date = "2024-07-16";
  };
  nvim-dap = {
    pname = "nvim-dap";
    version = "6f79b822997f2e8a789c6034e147d42bc6706770";
    src = fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-dap";
      rev = "6f79b822997f2e8a789c6034e147d42bc6706770";
      fetchSubmodules = false;
      sha256 = "sha256-MSH4pIUcAJBT8L1kBsU+D+7v6pMCMHKWz5lLug5VKgE=";
    };
    date = "2024-06-03";
  };
  nvim-dap-ui = {
    pname = "nvim-dap-ui";
    version = "a5606bc5958db86f8d92803bea7400ee26a8d7e4";
    src = fetchFromGitHub {
      owner = "rcarriga";
      repo = "nvim-dap-ui";
      rev = "a5606bc5958db86f8d92803bea7400ee26a8d7e4";
      fetchSubmodules = false;
      sha256 = "sha256-KW6Xeii9NeKXNPVzqSiK1qsBgxI6tFq2tygdIRc4kPM=";
    };
    date = "2024-07-13";
  };
  nvim-dap-virtual-text = {
    pname = "nvim-dap-virtual-text";
    version = "484995d573c0f0563f6a66ebdd6c67b649489615";
    src = fetchFromGitHub {
      owner = "theHamsta";
      repo = "nvim-dap-virtual-text";
      rev = "484995d573c0f0563f6a66ebdd6c67b649489615";
      fetchSubmodules = false;
      sha256 = "sha256-+f30i+Z/eQQk9v59BxwEgVWEqCevNgstoQSo6KdMCF0=";
    };
    date = "2024-07-02";
  };
  nvim-jdtls = {
    pname = "nvim-jdtls";
    version = "6bfd1591583b02e742fc3a2f43393c4ea3b6d3c7";
    src = fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-jdtls";
      rev = "6bfd1591583b02e742fc3a2f43393c4ea3b6d3c7";
      fetchSubmodules = false;
      sha256 = "sha256-0IM90e86PgRR8uyCep/psVOf5Xb+6tsfJfjXsrlEJ4A=";
    };
    date = "2024-07-12";
  };
  nvim-lspconfig = {
    pname = "nvim-lspconfig";
    version = "01e08d4bf1c35e5126b2ad5209725e4c552289ab";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lspconfig";
      rev = "01e08d4bf1c35e5126b2ad5209725e4c552289ab";
      fetchSubmodules = false;
      sha256 = "sha256-lue8eBy4iXLsc5wYB+X/AkjpcSY005Ih8mjlK0XM7MA=";
    };
    date = "2024-07-16";
  };
  nvim-navic = {
    pname = "nvim-navic";
    version = "8649f694d3e76ee10c19255dece6411c29206a54";
    src = fetchFromGitHub {
      owner = "SmiteshP";
      repo = "nvim-navic";
      rev = "8649f694d3e76ee10c19255dece6411c29206a54";
      fetchSubmodules = false;
      sha256 = "sha256-0p5n/V8Jlj9XyxV/fuMwsbQ7oV5m9H2GqZZEA/njxCQ=";
    };
    date = "2023-11-30";
  };
  nvim-nio = {
    pname = "nvim-nio";
    version = "a428f309119086dc78dd4b19306d2d67be884eee";
    src = fetchFromGitHub {
      owner = "nvim-neotest";
      repo = "nvim-nio";
      rev = "a428f309119086dc78dd4b19306d2d67be884eee";
      fetchSubmodules = false;
      sha256 = "sha256-i6imNTb1xrfBlaeOyxyIwAZ/+o6ew9C4/z34a7/BgFg=";
    };
    date = "2024-07-11";
  };
  nvim-spectre = {
    pname = "nvim-spectre";
    version = "9a28f926d3371b7ef02243cbbb653a0478d06e31";
    src = fetchFromGitHub {
      owner = "nvim-pack";
      repo = "nvim-spectre";
      rev = "9a28f926d3371b7ef02243cbbb653a0478d06e31";
      fetchSubmodules = false;
      sha256 = "sha256-Y8iHDlnv/zUbkaFqT2+DpMGyrrzZAhgyYfl7iPw625Q=";
    };
    cargoLock."spectre_oxi/Cargo.lock" = {
      lockFile = ./nvim-spectre-9a28f926d3371b7ef02243cbbb653a0478d06e31/spectre_oxi/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2024-07-08";
  };
  nvim-surround = {
    pname = "nvim-surround";
    version = "ec2dc7671067e0086cdf29c2f5df2dd909d5f71f";
    src = fetchFromGitHub {
      owner = "kylechui";
      repo = "nvim-surround";
      rev = "ec2dc7671067e0086cdf29c2f5df2dd909d5f71f";
      fetchSubmodules = false;
      sha256 = "sha256-DCNfT//qMnzIu4V9or3Q39h4XzLz9P4twtHnQHV2rrQ=";
    };
    date = "2024-06-24";
  };
  nvim-tree-lua = {
    pname = "nvim-tree-lua";
    version = "f9ff00bc06d7cb70548a3847d7a2a05e928bc988";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-tree.lua";
      rev = "f9ff00bc06d7cb70548a3847d7a2a05e928bc988";
      fetchSubmodules = false;
      sha256 = "sha256-0p6kz1/LZoIPRMmwpBjq/diP5fia4viQajuxQSHUe4M=";
    };
    date = "2024-07-11";
  };
  nvim-treesitter-context = {
    pname = "nvim-treesitter-context";
    version = "2aba92ceb1479485953007f4d5adf34d0b66917e";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter-context";
      rev = "2aba92ceb1479485953007f4d5adf34d0b66917e";
      fetchSubmodules = false;
      sha256 = "sha256-qLTI7/Tf76HnXsyhes+xLC9qy6eSYIEqiab4hvWdmRo=";
    };
    date = "2024-07-14";
  };
  nvim-treesitter-textobjects = {
    pname = "nvim-treesitter-textobjects";
    version = "34867c69838078df7d6919b130c0541c0b400c47";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter-textobjects";
      rev = "34867c69838078df7d6919b130c0541c0b400c47";
      fetchSubmodules = false;
      sha256 = "sha256-/NY5hHwNmHEBHUWOX4qX9QCHPJU8grWsaEtD+pAXDjE=";
    };
    date = "2024-06-05";
  };
  nvim-ts-autotag = {
    pname = "nvim-ts-autotag";
    version = "1624866a1379fc1861797f0ed05899a9c1d2ff61";
    src = fetchFromGitHub {
      owner = "windwp";
      repo = "nvim-ts-autotag";
      rev = "1624866a1379fc1861797f0ed05899a9c1d2ff61";
      fetchSubmodules = false;
      sha256 = "sha256-Ki2fks8NnztotWsf+UcmtZiRFkJRdIj27NPQipNrJbo=";
    };
    date = "2024-07-16";
  };
  nvim-web-devicons = {
    pname = "nvim-web-devicons";
    version = "c0cfc1738361b5da1cd0a962dd6f774cc444f856";
    src = fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-web-devicons";
      rev = "c0cfc1738361b5da1cd0a962dd6f774cc444f856";
      fetchSubmodules = false;
      sha256 = "sha256-j/B/E1VltJ/QpVFtDKAdVC4+KZ5Mz8dQP5kd8HIHjLs=";
    };
    date = "2024-06-09";
  };
  octo-nvim = {
    pname = "octo-nvim";
    version = "aa5dfa573220a0a511a25ee14ce1570b6c23e56a";
    src = fetchFromGitHub {
      owner = "pwntester";
      repo = "octo.nvim";
      rev = "aa5dfa573220a0a511a25ee14ce1570b6c23e56a";
      fetchSubmodules = false;
      sha256 = "sha256-nbCoDR+GJaELei+Bv+SxIlQ+ABwjWH4gDr7BmFViwp4=";
    };
    date = "2024-07-04";
  };
  plenary-nvim = {
    pname = "plenary-nvim";
    version = "a3e3bc82a3f95c5ed0d7201546d5d2c19b20d683";
    src = fetchFromGitHub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "a3e3bc82a3f95c5ed0d7201546d5d2c19b20d683";
      fetchSubmodules = false;
      sha256 = "sha256-5Jf2mWFVDofXBcXLbMa417mqlEPWLA+cQIZH/vNEV1g=";
    };
    date = "2024-05-20";
  };
  presence-nvim = {
    pname = "presence-nvim";
    version = "87c857a56b7703f976d3a5ef15967d80508df6e6";
    src = fetchFromGitHub {
      owner = "andweeb";
      repo = "presence.nvim";
      rev = "87c857a56b7703f976d3a5ef15967d80508df6e6";
      fetchSubmodules = false;
      sha256 = "sha256-ZpsunLsn//zYgUtmAm5FqKVueVd/Pa1r55ZDqxCimBk=";
    };
    date = "2023-01-29";
  };
  py_lsp-nvim = {
    pname = "py_lsp-nvim";
    version = "278db39aedd697613851861b5ea8b0d9138fc06f";
    src = fetchFromGitHub {
      owner = "hallerpatrick";
      repo = "py_lsp.nvim";
      rev = "278db39aedd697613851861b5ea8b0d9138fc06f";
      fetchSubmodules = false;
      sha256 = "sha256-cNvh7A091kdeLoaoz2ysWuNV0BqzTXgjntU/pDZS92U=";
    };
    date = "2024-02-15";
  };
  rainbow-delimiters = {
    pname = "rainbow-delimiters";
    version = "b29da4a6061a88270e875b38367d82c04c856128";
    src = fetchFromGitHub {
      owner = "hiphish";
      repo = "rainbow-delimiters.nvim";
      rev = "b29da4a6061a88270e875b38367d82c04c856128";
      fetchSubmodules = false;
      sha256 = "sha256-6+MSV9pkudhf/xVdofU6syYCzViHltvDWkYvbeuEfLs=";
    };
    date = "2024-07-07";
  };
  rustaceanvim = {
    pname = "rustaceanvim";
    version = "047f9c9d8cd2861745eb9de6c1570ee0875aa795";
    src = fetchFromGitHub {
      owner = "mrcjkb";
      repo = "rustaceanvim";
      rev = "047f9c9d8cd2861745eb9de6c1570ee0875aa795";
      fetchSubmodules = false;
      sha256 = "sha256-Mx8pB9ECjFpbfmZPuXfpwoE5pUZ363M53f27ht7MBmA=";
    };
    date = "2024-07-10";
  };
  schemastore-nvim = {
    pname = "schemastore-nvim";
    version = "2580d32172f66fa37c0e57fb14e1b5bc94ed9e15";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "schemastore.nvim";
      rev = "2580d32172f66fa37c0e57fb14e1b5bc94ed9e15";
      fetchSubmodules = false;
      sha256 = "sha256-Z7rRrsEaPwnnwJpZwYYyWRk7dTNVKORfRSJChp3RKQ4=";
    };
    date = "2024-07-15";
  };
  tagalong-vim = {
    pname = "tagalong-vim";
    version = "5a2bbf2b1d5b657685a49d48d98a4aa921c1fde3";
    src = fetchFromGitHub {
      owner = "AndrewRadev";
      repo = "tagalong.vim";
      rev = "5a2bbf2b1d5b657685a49d48d98a4aa921c1fde3";
      fetchSubmodules = false;
      sha256 = "sha256-zTdq7hg+tPTy803o+f3gIzb7TCw4KRgKAaLf7bBC1A4=";
    };
    date = "2023-09-07";
  };
  telescope-file-browser-nvim = {
    pname = "telescope-file-browser-nvim";
    version = "a7ab9a957b17199183388c6f357d614fcaa508e5";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-file-browser.nvim";
      rev = "a7ab9a957b17199183388c6f357d614fcaa508e5";
      fetchSubmodules = false;
      sha256 = "sha256-2ZXjp0Kzr2Xp7/BjiWBUi2lq6uS80Ada/pXLqxeBfDw=";
    };
    date = "2024-06-09";
  };
  telescope-nvim = {
    pname = "telescope-nvim";
    version = "bfcc7d5c6f12209139f175e6123a7b7de6d9c18a";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "bfcc7d5c6f12209139f175e6123a7b7de6d9c18a";
      fetchSubmodules = false;
      sha256 = "sha256-U6fgii9FlJy+bHAtYVnZEOyiUAqlBHTvMFc4mo+xS/s=";
    };
    date = "2024-07-01";
  };
  telescope-project-nvim = {
    pname = "telescope-project-nvim";
    version = "1aaf16580a614601a7f7077d9639aeb457dc5559";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-project.nvim";
      rev = "1aaf16580a614601a7f7077d9639aeb457dc5559";
      fetchSubmodules = false;
      sha256 = "sha256-touMCltcnqkrQYV1NtNeWLQeFVGt+WM3aIWIdKilA7w=";
    };
    date = "2023-12-01";
  };
  todo-comments-nvim = {
    pname = "todo-comments-nvim";
    version = "96fee098a90e7c09c9811aa7df71d773ba8b9b53";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "todo-comments.nvim";
      rev = "96fee098a90e7c09c9811aa7df71d773ba8b9b53";
      fetchSubmodules = false;
      sha256 = "sha256-D9kR4hD+sd+YnH7s66zbfMG2qKCxTeydU6ErpNzxhPU=";
    };
    date = "2024-07-15";
  };
  toggleterm-nvim = {
    pname = "toggleterm-nvim";
    version = "cd55bf6aab3f88c259fa29ea86bbdcb1a325687d";
    src = fetchFromGitHub {
      owner = "akinsho";
      repo = "toggleterm.nvim";
      rev = "cd55bf6aab3f88c259fa29ea86bbdcb1a325687d";
      fetchSubmodules = false;
      sha256 = "sha256-SR8KWVabXZAfhd9kcdjI7HXZWMIyFqwL5hv+1QDWrIo=";
    };
    date = "2024-06-25";
  };
  trouble-nvim = {
    pname = "trouble-nvim";
    version = "bf99ea71a39e322336b7f8be965f86dbf5c65540";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "trouble.nvim";
      rev = "bf99ea71a39e322336b7f8be965f86dbf5c65540";
      fetchSubmodules = false;
      sha256 = "sha256-RvjgVagdt19tSz7HDwAxLAZojjgsp6z2/GYGty9Ifmg=";
    };
    date = "2024-07-15";
  };
  typescript-tools-nvim = {
    pname = "typescript-tools-nvim";
    version = "3ecf6b29435dc7979eb5cdf1a9ff11bd65f5ea90";
    src = fetchFromGitHub {
      owner = "pmizio";
      repo = "typescript-tools.nvim";
      rev = "3ecf6b29435dc7979eb5cdf1a9ff11bd65f5ea90";
      fetchSubmodules = false;
      sha256 = "sha256-I6nglwLJB6U4CEL+SXV9RvFowZe7FeK9DN4AVT/qQ7o=";
    };
    date = "2024-07-15";
  };
  vim-applescript = {
    pname = "vim-applescript";
    version = "a39af8fc7e4caf581366e2917d558f6232e4db36";
    src = fetchFromGitHub {
      owner = "mityu";
      repo = "vim-applescript";
      rev = "a39af8fc7e4caf581366e2917d558f6232e4db36";
      fetchSubmodules = false;
      sha256 = "sha256-9asF5VMaKz3lfSsCTrvkicffgMbHY88wDZ+LJR9QTvY=";
    };
    date = "2022-01-21";
  };
  vim-dadbod = {
    pname = "vim-dadbod";
    version = "7888cb7164d69783d3dce4e0283decd26b82538b";
    src = fetchFromGitHub {
      owner = "tpope";
      repo = "vim-dadbod";
      rev = "7888cb7164d69783d3dce4e0283decd26b82538b";
      fetchSubmodules = false;
      sha256 = "sha256-8wnUSYctVn3JeCVz2fdi9qcKi8ZyA4To+xs4WaP6rog=";
    };
    date = "2024-05-31";
  };
  vim-dadbod-completion = {
    pname = "vim-dadbod-completion";
    version = "c3a56c652af9367c5a7b658ed7ed4dc494f430b0";
    src = fetchFromGitHub {
      owner = "kristijanhusak";
      repo = "vim-dadbod-completion";
      rev = "c3a56c652af9367c5a7b658ed7ed4dc494f430b0";
      fetchSubmodules = false;
      sha256 = "sha256-tVqQnIZrzXtM1+Blp1JUjE39X2v+E+c01WL5yDQGAwo=";
    };
    date = "2024-07-15";
  };
  vim-dadbod-ui = {
    pname = "vim-dadbod-ui";
    version = "954877c3396ad4bf5624fcbe7b5673ac43cd0928";
    src = fetchFromGitHub {
      owner = "kristijanhusak";
      repo = "vim-dadbod-ui";
      rev = "954877c3396ad4bf5624fcbe7b5673ac43cd0928";
      fetchSubmodules = false;
      sha256 = "sha256-jDqWcVIk8mXQXQuNsjc3VSGrgtuAchBdiEjgXPBkoME=";
    };
    date = "2024-07-15";
  };
  vim-gnupg = {
    pname = "vim-gnupg";
    version = "f9b608f29003dfde6450931dc0f495a912973a88";
    src = fetchFromGitHub {
      owner = "jamessan";
      repo = "vim-gnupg";
      rev = "f9b608f29003dfde6450931dc0f495a912973a88";
      fetchSubmodules = false;
      sha256 = "sha256-B6hSEeNjJdDUDjM0DlmAxc3zRRcJz91//GPk6rCWn6I=";
    };
    date = "2022-05-18";
  };
  vim-helm = {
    pname = "vim-helm";
    version = "ae1ebc160d2b9b90108477ab10df7a4fc501e358";
    src = fetchFromGitHub {
      owner = "towolf";
      repo = "vim-helm";
      rev = "ae1ebc160d2b9b90108477ab10df7a4fc501e358";
      fetchSubmodules = false;
      sha256 = "sha256-xrZ8MCuewAN/qIqSrbTuCtZocYZvXSSet26MYrYumxI=";
    };
    date = "2024-05-31";
  };
  vim-table-mode = {
    pname = "vim-table-mode";
    version = "e4365bde024f73e205eefa2fb78e3029ddb92ea9";
    src = fetchFromGitHub {
      owner = "dhruvasagar";
      repo = "vim-table-mode";
      rev = "e4365bde024f73e205eefa2fb78e3029ddb92ea9";
      fetchSubmodules = false;
      sha256 = "sha256-8p40cId8dQVhXHuusk2Mn2esRZm8vcY5EZbAXBPU/Fg=";
    };
    date = "2024-03-14";
  };
  which-key-nvim = {
    pname = "which-key-nvim";
    version = "bb4e82bdaff50a4a93867e4c90938d18e7615af6";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "which-key.nvim";
      rev = "bb4e82bdaff50a4a93867e4c90938d18e7615af6";
      fetchSubmodules = false;
      sha256 = "sha256-af893q7+0vJQ78OzVO/jeA2VxqM9v0XGwcvQKrh6GrE=";
    };
    date = "2024-07-16";
  };
  zen-mode-nvim = {
    pname = "zen-mode-nvim";
    version = "a31cf7113db34646ca320f8c2df22cf1fbfc6f2a";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "zen-mode.nvim";
      rev = "a31cf7113db34646ca320f8c2df22cf1fbfc6f2a";
      fetchSubmodules = false;
      sha256 = "sha256-7K923AlzQMJxMtfQcsbjv+kpbNA+tf4QLAtjMEkWBj0=";
    };
    date = "2024-07-15";
  };
}
