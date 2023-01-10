local M = {}

local indent = require "indent_blankline"

function M.setup()
  indent.setup {
    buftype_exclude = { "terminal", "telescope", "nofile" },
    filetype_exclude = { "alpha", "help", "dashboard", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float" },
    show_trailing_blankline_indent = false,
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = false,
    show_end_of_line = true,
  }
end

return M
