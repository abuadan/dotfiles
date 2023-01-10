local M = {}
local Log = require "utils.log"

function M.javascript_runner()
  local runners = { "cypress", "jest" }
  vim.ui.select(runners, { prompt = "Choose Javascript Runner" }, function(selected)
    if selected then
      vim.g["test#javascript#runner"] = selected
      Log.info("Test runner changed to " .. selected, "Test Runner")
    end
  end)
end

function M.setup()
  vim.api.nvim_exec(
    [[

    "let test#strategy = "neovim"
    let test#strategy = "dispatch"
    let test#neovim#term_position = "belowright"
    let g:test#preserve_screen = 1

    "Python"
    let test#python#runner = 'pytest'

    " -- Javascript
    let test#javascript#reactscripts#options = "--watchAll=false"
    let test#javascript#runner = "jest"
    let test#javascript#cypress#executable = "npx cypress run-ct"

]],
    false
  )
end

return M
