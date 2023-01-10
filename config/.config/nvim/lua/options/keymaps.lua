local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope
keymap("n", "<Leader><Space>", "<CMD>lua require'config.navigation.telescope'.project_files()<CR>", opts)
keymap("n", "<Leader>g", "<CMD>Telescope live_grep<CR>", opts)
keymap("n", "<Leader>b", "<CMD>lua require'config.navigation.telescope'.git_branches()<CR>", opts)
keymap("n", "<Leader>S", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)

-- NvimTree
keymap("n", "<Leader>nn", "<CMD>NvimTreeOpen<CR>", opts)
keymap("n", "<Leader>nf", "<CMD>NvimTreeFindFile<CR>", opts)
keymap("n", "<Leader>nt", "<CMD>NvimTreeToggle<CR>", opts)
-- keymap("n", "<Leader>n", "<CMD>NvimTreeFocus<CR>", opts)

-- Refactor
-- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap(
  "v",
  "<leader>re",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
  { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>rf",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
  { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>rv",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
  { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>ri",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false }
)

-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap(
  "n",
  "<leader>rb",
  [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
  { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>rbf",
  [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
  { noremap = true, silent = true, expr = false }
)

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap(
  "n",
  "<leader>ri",
  [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false }
)

-- Better copy/delete
-- next greatest remap ever : asbjornHaland
keymap({ "n", "v" }, "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]])

keymap({ "n", "v" }, "<leader>d", [["_d]], opts)

-- Better Motion
keymap("n", "J", "mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- save in insert mode
keymap("i", "<C-s>", "<cmd>:w<cr><esc>")
keymap("n", "<C-s>", "<cmd>:w<cr><esc>")
keymap("n", "<C-c>", "<cmd>normal ciw<cr>a")

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
