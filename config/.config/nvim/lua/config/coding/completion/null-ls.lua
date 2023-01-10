local M = {}

local Log = require "utils.log"
local mason = require "mason"

local mason_null_ls = require "mason-null-ls"

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  Log:error "Missing null-ls dependency"
  return
end

local null_ls_root =
  require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git", "pyproject.toml", "Pipfile")

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  }
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

function M.setup()
  local sources = {
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.ruff.with { extra_args = { "--max-line-length=180" } },
  }
  mason.setup()
  null_ls.setup {
    sources = sources,
    on_attach = on_attach,
    root_dir = null_ls_root,
  }

  mason_null_ls.setup {
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = false,
  }
end

return M
