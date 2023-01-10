-- local mason = require("config.coding.completion.mason")
local mason_lspconfig = require "mason-lspconfig"
local navic = require "nvim-navic"
--[[ local null_ls = require "config.coding.completion.null-ls" ]]
local lspconfig = require "lspconfig"

local M = {}

local function document_highlight(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = true,
    })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = "lsp_document_highlight",
    }
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end
end

local function semantic_tokens(client, bufnr)
  local caps = client.server_capabilities
  if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
    vim.api.nvim_create_autocmd("TextChanged", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.semantic_tokens_full()
      end,
    })
    -- fire it first time on load as well
    vim.lsp.buf.semantic_tokens_full()
  end
  --...
end

function M.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  local mappings = require("config.coding.completion.lsp_config.mappings").mappings
  local navic_ = require "config.coding.nvim-navic_"

  navic.attach(client, bufnr)
  navic_.set_highlight()

  -- Server capabilities spec:
  -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
  -- print(dump(client.server_capabilities))
  mappings(client, bufnr)
  document_highlight(client, bufnr)
  semantic_tokens(client, bufnr)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })
end

local function setup_kind(icons)
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = icons.kind[kind] or kind
  end
end

function M.setup()
  local icons = require "config.ide.icons"
  local diagnostics = require("config.coding.completion.lsp_config.diagnostics").diagnostics

  setup_kind(icons)
  diagnostics()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local servers = {
    "sumneko_lua",
    "rust_analyzer",
    "pyright",
    "tsserver",
    "yamlls",
    "terraformls",
    "angularls",
    "ansiblels",
    "cssls",
    "dockerls",
    "gopls",
    "jsonls",
    "sqls",
    "taplo",
    "clangd",
    "bashls",
  }

  mason_lspconfig.setup {
    ensure_installed = servers,
    automatic_installation = true,
  }

  for _, server in pairs(servers) do
    local server_opts = {
      on_attach = M.on_attach,
      capabilities = capabilities,
    }
    -- server = vim.split(server, "@")[1]
    local require_ok, conf_opts = pcall(require, "config.coding.completion.servers." .. server)
    if require_ok then
      server_opts = vim.tbl_deep_extend("force", conf_opts, server_opts)
    end

    lspconfig[server].setup(server_opts)
  end
end

return M
