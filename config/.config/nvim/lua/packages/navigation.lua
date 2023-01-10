local packer = require "packer"
local use = packer.use

-- Harpoon
use {
  "ThePrimeagen/harpoon",
  requires = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("config.navigation.harpoon").setup()
  end,
}

-- Telescope
use {
  "nvim-telescope/telescope.nvim",
  event = { "VimEnter" },
  config = function()
    require("config.navigation.telescope").setup()
  end,
  requires = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    },
    {
      "nvim-telescope/telescope-project.nvim",
      requires = {
        "ahmedkhalf/project.nvim",
        config = function()
          require("config.ide.project").setup()
        end,
      },
    },
    { "cljoly/telescope-repo.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    {
      "nvim-telescope/telescope-frecency.nvim",
      requires = "tami5/sqlite.lua",
    },
    { "nvim-telescope/telescope-dap.nvim" },
    {
      "AckslD/nvim-neoclip.lua",
      requires = {
        { "tami5/sqlite.lua", module = "sqlite" },
      },
    },
    { "nvim-telescope/telescope-smart-history.nvim" },
    -- {
    --   "alpha2phi/telescope-arecibo.nvim",
    --   rocks = { "openssl", "lua-http-parser" },
    -- },
    { "nvim-telescope/telescope-media-files.nvim" },
    { "dhruvmanila/telescope-bookmarks.nvim" },
    { "nvim-telescope/telescope-github.nvim" },
    { "jvgrootveld/telescope-zoxide" },
    { "Zane-/cder.nvim" },
    "nvim-telescope/telescope-symbols.nvim",
  },
}
