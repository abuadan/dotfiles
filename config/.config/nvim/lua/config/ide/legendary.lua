local M = {}
local legendary = require "legendary"
local keymap = vim.api.nvim_set_keymap
local default_opts = {
  noremap = true,
  silent = true,
}

function M.setup()
  legendary.setup {
    which_key = {
      -- Automatically add which-key tables to legendary
      -- see ./doc/WHICH_KEY.md for more details
      auto_register = true,
      -- you can put which-key.nvim tables here,
      -- or alternatively have them auto-register,
      -- see ./doc/WHICH_KEY.md
      mappings = {},
      opts = {},
      -- controls whether legendary.nvim actually binds they keymaps,
      -- or if you want to let which-key.nvim handle the bindings.
      -- if not passed, true by default
      do_binding = true,
    },
    include_builtin = true,
  }
  keymap("n", "<C-p>", "<cmd>lua require('legendary').find()<CR>", default_opts)
end

return M
