local attempt = require "attempt"
local unix = vim.fn.has "unix" == 1
local path_separator = unix and "/" or "\\"

local cpp_compiler = "g++"
local c_compiler = "gcc"

local function initial_content_fn(ext)
  return require("attempt.initial_content." .. ext)
end

local M = {}

function M.setup()
  attempt.setup {
    dir = (unix and "/tmp/" or vim.fn.expand "$TEMP\\") .. "attempt.nvim" .. path_separator,
    autosave = false,
    list_buffers = false, -- This will make them show on other pickers (like :Telescope buffers)
    initial_content = {
      py = initial_content_fn, -- Either string or function that returns the initial content
      c = initial_content_fn,
      cpp = initial_content_fn,
      java = initial_content_fn,
      rs = initial_content_fn,
      go = initial_content_fn,
      sh = initial_content_fn,
    },
    ext_options = { "lua", "js", "py", "cpp", "c", "" }, -- Options to choose from
    format_opts = { [""] = "[None]" }, -- How they'll look
    run = {
      py = { "w !python" }, -- Either table of strings or lua functions
      js = { "w !node" },
      lua = { "w", "luafile %" },
      sh = { "w !bash" },
      pl = { "w !perl" },
      cpp = { "w", "!" .. cpp_compiler .. ' %:p -o %:p:r.out && echo "" && %:p:r.out && rm %:p:r.out ' },
      c = { "w", "!" .. c_compiler .. ' %:p -o %:p:r.out && echo "" && %:p:r.out && rm %:p:r.out' },
    },
  }
end

function M.map(mode, l, r, opts)
  opts = opts or {}
  opts = vim.tbl_extend("force", { silent = true }, opts)
  vim.keymap.set(mode, l, r, opts)
end

M.map("n", "<leader>an", attempt.new_select) -- new attempt, selecting extension
M.map("n", "<leader>ai", attempt.new_input_ext) -- new attempt, inputing extension
M.map("n", "<leader>ar", attempt.run) -- run attempt
M.map("n", "<leader>ad", attempt.delete_buf) -- delete attempt from current buffer
M.map("n", "<leader>ac", attempt.rename_buf) -- rename attempt from current buffer
M.map("n", "<leader>al", "Telescope attempt") -- search through attempts
--or: map('n', '<leader>al', attempt.open_select) -- use ui.select instead of telescope

return M
