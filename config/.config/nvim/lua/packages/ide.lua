local packer = require "packer"
local use = packer.use

-- UI
-- Packer
use {
  "folke/noice.nvim",
  config = function()
    require("config.ide.noice").setup()
  end,
  requires = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup {
          -- Animation style
          stages = "fade_in_slide_out",
          -- Default timeout for notifications
          timeout = 1500,
          background_colour = "#2E3440",
        }
      end,
    },
  },
}
use "MunifTanjim/nui.nvim"

-- Terminal
use {
  "akinsho/toggleterm.nvim",
  tag = "*",
  config = function()
    require("config.ide.toggleterm").setup()
  end,
}
-- shader
use "sunjon/shade.nvim"

-- Start Screen
use {
  "goolord/alpha-nvim",
  requires = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("config.ide.alpha").setup()
  end,
}
-- Treesitter
use {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
    require("config.ide.treesitter").setup()
  end,
  requires = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      event = "BufReadPre",
    },
    {
      "windwp/nvim-ts-autotag",
      event = "InsertEnter",
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "BufReadPre",
    },
    {
      "p00f/nvim-ts-rainbow",
      event = "BufReadPre",
    },
    {
      "RRethy/nvim-treesitter-textsubjects",
      event = "BufReadPre",
    },
    {
      "nvim-treesitter/playground",
      cmd = { "TSPlaygroundToggle" },
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "BufReadPre",
      disable = true,
    },
    {
      "mfussenegger/nvim-treehopper",
      module = { "tsht" },
      disable = true,
    },
    -- {
    --   "m-demare/hlargs.nvim",
    --   config = function()
    --     require("config.ide.hlargs").setup()
    --   end,
    --   disable = false,
    -- },
    {
      "AckslD/nvim-FeMaco.lua",
      config = function()
        require("femaco").setup()
      end,
      ft = { "markdown" },
      cmd = { "Femaco" },
      module = { "femaco_edit" },
      disable = false,
    },
  },
}

use {
  "simrat39/symbols-outline.nvim",
  config = function()
    require("config.ide.symbols-outline").setup()
  end,
}
-- Better Parenthesis
use { "p00f/nvim-ts-rainbow" } -- rainbow parenthesis

use {
  "windwp/nvim-autopairs",
  opt = true,
  event = "InsertEnter",
  module = { "nvim-autopairs.completion.cmp_", "nvim-autopairs" },
  config = function()
    require("config.ide.autopairs").setup()
  end,
}

-- icons

use { "nvim-tree/nvim-web-devicons" }
use {
  "kosayoda/nvim-lightbulb",
  requires = "antoinemadec/FixCursorHold.nvim",
}

-- Bufferline
use "famiu/bufdelete.nvim"
use {
  "akinsho/bufferline.nvim",
  tag = "v3.*",
  config = function()
    require("config.ide.bufferline").setup()
  end,
  requires = "nvim-tree/nvim-web-devicons",
}

-- LuaLine

use {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("config.ide.lualine").setup()
  end,
  requires = {
    "nvim-tree/nvim-web-devicons",
    "glepnir/lspsaga.nvim",
  },
}

-- Nvim-Tree

use {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("config.ide.nvim-tree").setup()
  end,
  requires = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
}

-- Project Management
use {
  "ahmedkhalf/project.nvim",
  config = function()
    require("config.ide.project").setup()
  end,
  -- after = 'nvim-telescope/telescope.nvim'
}

-- Marks
use {
  "chentoast/marks.nvim",
  event = "BufReadPre",
  config = function()
    require("marks").setup()
  end,
}

-- Key Mapping

use {
  "folke/which-key.nvim",
  config = function()
    require("config.ide.which-key").setup()
  end,
}

use {
  "mrjones2014/legendary.nvim",
  -- sqlite is only needed if you want to use frecency sorting
  requires = { "kkharji/sqlite.lua", "stevearc/dressing.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    require("config.ide.legendary").setup()
  end,
}

use { "mbbill/undotree" }
use { "kamykn/spelunker.vim" }
use { "windwp/nvim-spectre" }

use {
  "andymass/vim-matchup",
  event = "CursorMoved",
}

use {
  "wellle/targets.vim",
  event = "BufWinEnter",
  disable = false,
}

use {
  "unblevable/quick-scope",
  keys = { "F", "f", "T", "t" },
  -- config = function()
  --   vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
  -- end,
  disable = false,
}

-- Motions
use {
  "ggandor/leap.nvim",
  requires = "tpope/vim-repeat",
  config = function()
    require("leap").add_default_mappings()
  end,
}
use { "chaoren/vim-wordmotion" }
use {
  "easymotion/vim-easymotion",
  event = "BufRead",
  disable = true,
}
use {
  "phaazon/hop.nvim",
  branch = "v2", -- optional but strongly recommended
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require("config.ide.motion.hop").setup()
  end,
  disable = true,
}

-- Org
use {
  "nvim-neorg/neorg",
  after = { "nvim-treesitter" },
  run = ":Neorg sync-parsers",
  config = function()
    require("config.ide.neorg").setup()
  end,
  -- ft = "norg",
  -- opt = true,
  requires = { "nvim-lua/plenary.nvim", "Pocco81/TrueZen.nvim" },
  disable = false,
}

-- IndentLine
use {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  config = function()
    require("config.ide.indent-blanklines").setup()
  end,
}
