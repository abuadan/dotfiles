local bufferline = require "bufferline"
local icons = require "config.ide.icons"
local M = {}

function M.setup()
  bufferline.setup {
    options = {
      buffer_close_icon = icons.ui.Close,
      close_command = "Bdelete %d",
      close_icon = "",
      indicator = {
        icon = " ",
      },
      left_trunc_marker = icons.ui.ArrowCircleLeft,
      modified_icon = icons.ui.Circle,
      offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
      right_mouse_command = "Bdelete! %d",
      right_trunc_marker = icons.ui.ArrowCircleRight,
      show_close_icon = false,
      show_tab_indicators = true,
    },
    highlights = {
      fill = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLineNC" },
      },
      background = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLine" },
      },
      buffer_visible = {
        underline = false,
        undercurl = false,
        italic = false,
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      buffer_selected = {
        underline = false,
        undercurl = false,
        italic = false,
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      separator = {
        fg = { attribute = "bg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLine" },
      },
      separator_selected = {
        fg = { attribute = "fg", highlight = "Special" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      separator_visible = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLineNC" },
      },
      close_button = {
        fg = { attribute = "fg", highlight = "Normal" },
        bg = { attribute = "bg", highlight = "StatusLine" },
      },
      close_button_selected = {
        fg = { attribute = "fg", highlight = "normal" },
        bg = { attribute = "bg", highlight = "normal" },
      },
      close_button_visible = {
        fg = { attribute = "fg", highlight = "normal" },
        bg = { attribute = "bg", highlight = "normal" },
      },
    },
  }
end
return M
