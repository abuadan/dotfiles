local navic = require "nvim-navic"
local icons = require "config.ide.icons"
local M = {}

-- Color table for highlights
local colors = {
  fg = "#bbc2cf",
  red = "#e95678",
  orange = "#FF8700",
  yellow = "#f7bb3b",
  green = "#afd700",
  cyan = "#36d0e0",
  blue = "#61afef",
  violet = "#CBA6F7",
  teal = "#1abc9c",
}

local kind = {
  [1] = { "File", icons.kind.File, colors.fg },
  [2] = { "Module", icons.kind.Module, colors.blue },
  [3] = { "Namespace", icons.kind.Package, colors.orange },
  [4] = { "Package", icons.kind.Package, colors.violet },
  [5] = { "Class", icons.kind.Class, colors.violet },
  [6] = { "Method", icons.kind.Method, colors.violet },
  [7] = { "Property", icons.kind.Property, colors.cyan },
  [8] = { "Field", icons.kind.Field, colors.teal },
  [9] = { "Constructor", icons.kind.Constructor, colors.blue },
  [10] = { "Enum", icons.kind.Enum, colors.green },
  [11] = { "Interface", icons.kind.Interface, colors.orange },
  [12] = { "Function", icons.kind.Function, colors.violet },
  [13] = { "Variable", icons.kind.Variable, colors.blue },
  [14] = { "Constant", icons.kind.Constant, colors.cyan },
  [15] = { "String", icons.kind.String, colors.green },
  [16] = { "Number", icons.kind.Number, colors.green },
  [17] = { "Boolean", icons.kind.Boolean, colors.orange },
  [18] = { "Array", icons.kind.Array, colors.blue },
  [19] = { "Object", icons.kind.Object, colors.orange },
  [20] = { "Key", icons.kind.Key, colors.red },
  [21] = { "Null", icons.kind.Null, colors.red },
  [22] = { "EnumMember", icons.kind.EnumMember, colors.green },
  [23] = { "Struct", icons.kind.Struct, colors.violet },
  [24] = { "Event", icons.kind.Event, colors.violet },
  [25] = { "Operator", icons.kind.Operator, colors.green },
  [26] = { "TypeParameter", icons.kind.TypeParameter, colors.green },
  -- ccls
  -- [252] = { "TypeAlias", icons.kind.TypeAlias, colors.green },
  -- [253] = { "Parameter", icons.kind.Parameter, colors.blue },
  -- [254] = { "StaticMethod", icons.kind.StaticMethod, colors.orange },
  -- [255] = { "Macro", icons.kind.Macro, colors.red },
}

function M.set_highlight()
  local prefix = "NavicIcons"

  for _, v in pairs(kind) do
    vim.api.nvim_set_hl(0, prefix .. v[1], { default = true, bg = "#000000", fg = v[3] })
  end
  vim.api.nvim_set_hl(0, prefix .. "Text", { fg = colors.fg, bold = true })
end

function M.setup()
  local vscode_icons = {}
  for _, v in pairs(kind) do
    vscode_icons[v[1]] = v[2]
  end

  navic.setup {
    icons = vscode_icons,
    highlight = true,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "...",
  }
end
return M
