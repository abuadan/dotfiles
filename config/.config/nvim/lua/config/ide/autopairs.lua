local M = {}
local autopairs = require("nvim-autopairs")

function M.setup()
  autopairs.setup {
    disable_filetype = { "TelescopePrompt", "vim" },
  }    
end

return M
