local packer = require "packer"
local use = packer.use
local g = vim.g
local cmd = vim.cmd

-- Themes
use {
  "rebelot/kanagawa.nvim",
  config = function()
    require("config.themes.kanagawa").setup()
  end,
  disable = true,
}
use {
  "Mofiqul/vscode.nvim",
  config = function()
    require("config.themes.vscode").setup()
  end,
  disable = false,
}

use {
  "folke/tokyonight.nvim",
  config = function()
    require("config.themes.tokyonight").setup()
    cmd "colorscheme tokyonight-storm"
  end,
  disable = true,
}

use {
  "martinsione/darkplus.nvim",
  -- config = function()
  --   cmd [[colorscheme darkplus]]
  -- end,
  disable = true,
}
use {
  "sainnhe/everforest",
  config = function()
    g.everforest_better_performance = 1
    cmd "colorscheme everforest"
  end,
  disable = true,
}
use {
  "projekt0n/github-nvim-theme",
  disable = true,
}
use {
  "sainnhe/gruvbox-material",
  config = function()
    cmd "colorscheme gruvbox-material"
  end,
  disable = true,
}
use {
  "arcticicestudio/nord-vim",
  config = function()
    cmd "colorscheme nord"
  end,
  disable = true,
}
