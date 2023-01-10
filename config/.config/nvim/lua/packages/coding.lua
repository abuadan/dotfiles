local packer = require "packer"
local use = packer.use

-- Completion
use {
  "hrsh7th/nvim-cmp",
  -- event = "InsertEnter",
  -- opt = true,
  config = function()
    require("config.coding.completion.cmp_").setup()
  end,
  requires = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "ray-x/cmp-treesitter",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "lukas-reineke/cmp-rg",
    "davidsierradz/cmp-conventionalcommits",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-calc",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    {
      "L3MON4D3/LuaSnip",
      config = function()
        require("config.coding.snippets.luasnip_").setup()
      end,
      module = { "luasnip" },
    },
    "rafamadriz/friendly-snippets",
    "honza/vim-snippets",
    disable = false,
  },
}

use {
  "m-demare/hlargs.nvim",
  requires = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("hlargs").setup()
  end,
}

use {
  "SmiteshP/nvim-navic",
  config = function()
    require("config.coding.nvim-navic_").setup()
  end,
  requires = "neovim/nvim-lspconfig",
}

-- LSP
use {
  "neovim/nvim-lspconfig",
  config = function()
    require("config.coding.completion.lspconfig").setup()
    -- require("config.coding.debugging.dap").setup()
  end,
  after = "nvim-treesitter",
  requires = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jayp0521/mason-null-ls.nvim",
    "folke/neodev.nvim",
    {
      "RRethy/vim-illuminate",
      config = function()
        vim.g.Illuminate_delay = 300
        vim.g.Illuminate_highlightUnderCursor = 0
        -- vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
        -- vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
        -- vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]
        -- vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
        -- vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
      end,
    },
    {
      "jose-elias-alvarez/null-ls.nvim", -- after = "nvim-lspconfig",
      config = function()
        require("config.coding.completion.null-ls").setup()
      end,
    },
    {
      "b0o/schemastore.nvim",
      module = { "schemastore" },
    },
    {
      "jose-elias-alvarez/typescript.nvim",
      module = { "typescript" },
    },
    {
      "simrat39/inlay-hints.nvim",
      config = function()
        require("inlay-hints").setup()
      end,
    },
    {
      "theHamsta/nvim-semantic-tokens",
      config = function()
        require("config.coding.completion.semantictokens").setup()
      end,
      disable = false,
    },
  },
}
use {
  "glepnir/lspsaga.nvim",
  cmd = { "Lspsaga" },
  config = function()
    require "config.coding.completion.lspsaga"
  end,
  opt = false,
  disable = false,
}

use {
  "weilbith/nvim-code-action-menu",
  cmd = "CodeActionMenu",
}
-- Refactor
use {
  "smjonas/inc-rename.nvim",
  config = function()
    require("config.coding.inc_rename").setup()
  end,
}
use {
  "ThePrimeagen/refactoring.nvim",
  requires = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
}

-- Diagnostics
use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("config.coding.trouble").setup()
  end,
}

-- Git
use {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("config.coding.git.gitsigns_").setup()
  end,
}

use {
  "tpope/vim-fugitive",
  opt = true,
  cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
  requires = {
    "idanarye/vim-merginal", -- "tpope/vim-rhubarb",
    -- "rhysd/committia.vim",
  },
}

-- Better surround
use {
  "tpope/vim-surround",
  event = "BufReadPre",
}
-- Better Comment
use {
  "numToStr/Comment.nvim",
  requires = "JoosepAlviste/nvim-ts-context-commentstring",
  keys = { "gc", "gcc", "gbc" },
  config = function()
    require("config.coding.comment").setup()
  end,
  disable = false,
}
use {
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("config.coding.todocomments").setup()
  end,
}

-- Strip Whitespace
use "ntpeters/vim-better-whitespace"

-- Test
use {
  "nvim-neotest/neotest",
  requires = {
    {
      "vim-test/vim-test",
      event = { "BufReadPre" },
      config = function()
        require("config.coding.testing.vim_test").setup()
      end,
    },
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    {
      "nvim-neotest/neotest-vim-test",
      module = { "neotest-vim-test" },
    },
    {
      "nvim-neotest/neotest-python",
      module = { "neotest-python" },
    },
    {
      "nvim-neotest/neotest-plenary",
      module = { "neotest-plenary" },
    },
    {
      "nvim-neotest/neotest-go",
      module = { "neotest-go" },
    },
    {
      "haydenmeade/neotest-jest",
      module = { "neotest-jest" },
    },
    {
      "rouge8/neotest-rust",
      module = { "neotest-rust" },
    },
  },
  module = { "neotest", "neotest.async" },
  config = function()
    require("config.coding.testing.neotest").setup()
  end,
  disable = false,
}

use {
  "m-demare/attempt.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    require("config.coding.attempt").setup()
  end,
}

-- Markdown
use {
  "iamcco/markdown-preview.nvim",
  run = function()
    vim.fn["mkdp#util#install"]()
  end,
}

-- Colors
use {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup()
  end,
}
