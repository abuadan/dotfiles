local default_workspace = {
  library = {
    -- [vim.fn.expand "$VIMRUNTIME/lua"] = true,
    -- [vim.fn.stdpath "config" .. "/lua"] = true,
    -- require("neodev.config").types(),
    -- Make the server aware of Neovim runtime files
    vim.api.nvim_get_runtime_file("", true),
  },

  maxPreload = 10000,
  preloadFileSize = 10000,
  checkThirdParty = false,
}
return {
  single_file_support = true,
  filetypes = { "lua" },
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
      runtime = {
        version = "LuaJIT",
        special = {
          reload = "require",
        },
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = default_workspace,
      completion = {
        workspaceWord = true,
        callSnippet = "Both",
      },
    },
  },
}
