local M = {}

local noice = require "noice"

local focused = true
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    focused = true
  end,
})
vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    focused = false
  end,
})

function M.setup()
  -- vim.set.highl(0, NotifyBackground, )

  noice.setup {
    debug = false,
    routes = {
      {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      },
      {
        filter = {
          event = "msg_show",
          find = "%d+L, %d+B",
        },
        view = "mini",
      },
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
      cmdline_output_to_split = false,
    },
    commands = {
      all = {
        -- options for the message history that you get with `:Noice`
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {},
      },
    },
    format = {
      level = {
        icons = false,
      },
    },
  }
end

return M
