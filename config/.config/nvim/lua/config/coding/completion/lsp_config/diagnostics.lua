local M = {}
local icons = require "config.ide.icons"

function M.diagnostics()
  local opts = { noremap = true, silent = true }
  -- Show line diagnostics
  vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

  -- Show cursor diagnostics
  vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

  -- Diagnostic jump can use `<c-o>` to jump back
  vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

  -- -- Default diagnostics keymaps
  -- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
  -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  -- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

  local signs = {

    { name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.BoldWarning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.BoldWarning },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.BoldHint },
  }

  -- for _, sign in ipairs(signs) do
  --   vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  -- end

  local config = {
    virtual_text = true, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)
end

return M
