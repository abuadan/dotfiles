local M = {}
local neotest = require("neotest")

function M.setup()
  neotest.setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
        runner = "pytest",
      },
      require "neotest-jest",
      require "neotest-go",
      require "neotest-plenary",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua" },
      },
    },
  }
end

return M
