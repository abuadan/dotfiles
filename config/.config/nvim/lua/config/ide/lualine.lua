local M = {}
local lualine = require "lualine"
local navic = require "nvim-navic"

local function empty_winbar_var()
  local exclude = {
    ["terminal"] = true,
    ["toggleterm"] = true,
    ["prompt"] = true,
    ["NvimTree"] = true,
    ["help"] = true,
  } -- Ignore float windows and exclude filetype
  if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
    return nil
  else
    return " "
  end
end

function M.setup()
  lualine.setup {
    options = {
      icons_enabled = true,
      theme = "vscode",
      -- component_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {
          "help",
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "NvimTree",
          "Trouble",
          "alpha",
          "lir",
          "Outline",
          "spectre_panel",
          "toggleterm",
        },
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 100,
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        -- config_winbar_or_statusline,
        -- require("lspsaga.symbolwinbar").get_symbol_node,
        { navic.get_location, cond = navic.is_available },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { empty_winbar_var } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {},
  }
end
return M
