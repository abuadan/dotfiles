local M = {}

local whichkey = require "which-key"
-- local legendary = require "legendary"
-- local next = next

local conf = {
  window = {
    border = "double", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}
whichkey.setup(conf)

local opts = {
  mode = "n", -- Normal mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
  local keymap_f = nil -- File search
  local keymap_p = nil -- Project search

  keymap_f = {
    name = "Find",
    f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
    p = { "<CMD>lua require'config.navigation.telescope'.project_files()<CR>", "Search Project" },
    g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
    b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
    h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
    m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
    o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
    c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
    r = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>", "File Browser" },
    w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
    e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  }

  keymap_p = {
    name = "Project",
    p = { "<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>", "List" },
    s = { "<cmd>lua require'telescope'.extensions.repo.list{}<cr>", "Search" },
    P = { "<cmd>TermExec cmd='BROWSER=brave yarn dev'<cr>", "Slidev" },
  }

  local keymap = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    -- ["t"] = { "<cmd>ToggleTerm<CR>", "Terminal" },

    a = {
      name = "Attempt",
      n = { "<Cmd>lua require('attempt').new_select()<Cr>", "New Select" },
      i = { "<Cmd>lua require('attempt').new_input_ext()<Cr>", "New Input Extension" },
      r = { "<Cmd>lua require('attempt').run()<Cr>", "Run" },
      d = { "<Cmd>lua require('attempt').delete_buf()<Cr>", "Delete Buffer" },
      c = { "<Cmd>lua require('attempt').rename_buf()<Cr>", "Rename Buffer" },
      s = { "<Cmd>Telescope attempt<Cr>", "Search" },
    },

    b = {
      name = "Buffer",
      c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
      f = { "<Cmd>bdelete!<Cr>", "Force Close Buffer" },
      D = { "<Cmd>BWipeout other<Cr>", "Delete All Buffers" },
      b = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
      p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
      m = { "<Cmd>JABSOpen<Cr>", "Menu" },
    },

    c = {
      -- TODO add Lspsaga keymaps
      name = "Code",
      g = { "<cmd>Neogen func<Cr>", "Func Doc" },
      G = { "<cmd>Neogen class<Cr>", "Class Doc" },
      d = { "<cmd>DogeGenerate<Cr>", "Generate Doc" },
      o = { "<cmd>Telescope aerial<Cr>", "Outline" },
      T = { "<cmd>TodoTelescope<Cr>", "TODO" },
      x = {
        name = "Swap Next",
        f = "Function",
        p = "Parameter",
        c = "Class",
      },
      X = {
        name = "Swap Previous",
        f = "Function",
        p = "Parameter",
        c = "Class",
      },
    },

    d = {
      -- TODO add debug
      name = "Debug",
    },

    f = keymap_f,
    p = keymap_p,

    j = {
      name = "Jump",
      a = { "<Cmd>lua require('harpoon.mark').add_file()<Cr>", "Add File" },
      m = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>", "UI Menu" },
      c = { "<Cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<Cr>", "Command Menu" },
    },
    ["0"] = { "<Cmd>2ToggleTerm<Cr>", "ToggleTerm 2" },
    ["1"] = { "<Cmd>lua require('harpoon.ui').nav_file(1) <Cr>", "File 1" },
    ["2"] = { "<Cmd>lua require('harpoon.ui').nav_file(2) <Cr>", "File 2" },
    ["3"] = { "<Cmd>lua require('harpoon.term').gotoTerminal(1)<Cr>", "Terminal 1" },
    ["4"] = { "<Cmd>lua require('harpoon.term').gotoTerminal(2)<Cr>", "Terminal 2" },
    ["5"] = { "<Cmd>lua require('harpoon.term').sendCommand(1,1)<Cr>", "Command 1" },
    ["6"] = { "<Cmd>lua require('harpoon.term').sendCommand(1,2)<Cr>", "Command 2" },

    o = {
      name = "Overseer",
      C = { "<cmd>OverseerClose<cr>", "OverseerClose" },
      a = { "<cmd>OverseerTaskAction<cr>", "OverseerTaskAction" },
      b = { "<cmd>OverseerBuild<cr>", "OverseerBuild" },
      c = { "<cmd>OverseerRunCmd<cr>", "OverseerRunCmd" },
      d = { "<cmd>OverseerDeleteBundle<cr>", "OverseerDeleteBundle" },
      l = { "<cmd>OverseerLoadBundle<cr>", "OverseerLoadBundle" },
      o = { "<cmd>OverseerOpen!<cr>", "OverseerOpen" },
      q = { "<cmd>OverseerQuickAction<cr>", "OverseerQuickAction" },
      r = { "<cmd>OverseerRun<cr>", "OverseerRun" },
      s = { "<cmd>OverseerSaveBundle<cr>", "OverseerSaveBundle" },
      t = { "<cmd>OverseerToggle!<cr>", "OverseerToggle" },
    },

    t = {
      name = "Test",
      a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
      f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
      F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
      l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
      L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
      n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
      N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
      o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
      S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
      s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
      p = { "<Plug>PlenaryTestFile", "PlenaryTestFile" },
      v = { "<cmd>TestVisit<cr>", "Visit" },
      x = { "<cmd>TestSuite<cr>", "Suite" },
      t = {
        name = "Test",
        l = { "<cmd>TestLast<cr>", "Run Last" },
        n = { "<cmd>TestNearest<cr>", "Run Nearest" },
      },
    },

    -- r = {
    --   name = "Refactor",
    --   i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
    --   b = { [[<cmd>lua require('refactoring').refactor('Exract Block')<cr>]], "Extract Block" },
    --   B = { [[<cmd>lua require('refactoring').refactor('Exract Block To File')<cr>]], "Extract Block to File" },
    --   P = {
    --     [[<cmd>lua require('refactoring').debug.printf({below = false})<cr>]],
    --     "Debug Print",
    --   },
    --   p = {
    --     [[<cmd>lua require('refactoring').debug.print_var({normal = true})<cr>]],
    --     "Debug Print Variable",
    --   },
    --   c = { [[<cmd>lua require('refactoring').debug.cleanup({})<cr>]], "Debug Cleanup" },
    -- },
    --
    x = {
      name = "External",
      g = { "<cmd> lua require('config.ide.toggleterm').lazygit()<CR>", "Lazy Git" },
      d = { "<cmd>lua require('config.ide.toggleterm').lazydocker()<CR>", "Lazy Docker" },
      t = { "<cmd>lua require('config.ide.toggleterm').docker_ctop()<CR>", "Docker - ctop" },
      -- y = { "<cmd>lua require('config.ide.toggleterm').docker_dockly()<CR>", "Docker - dockly" },
      s = { "<cmd>lua require('config.ide.toggleterm').navi()<CR>", "Interactive Cheatsheet" },
    },

    z = {
      name = "System",
      -- c = { "<cmd>PackerCompile<cr>", "Compile" },
      c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
      D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      m = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", "Macros" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
      -- x = { "<cmd>cd %:p:h<cr>", "Change Directory" },
      -- x = { "<cmd>set autochdir<cr>", "Auto ChDir" },
      x = { "<cmd>Telescope cder<cr>", "Change Directory" },
      e = { "!!$SHELL<CR>", "Execute line" },
      z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", "Zoxide" },
    },

    g = {
      name = "Git",
      b = { "<cmd>GitBlameToggle<CR>", "Blame" },
      p = { "<cmd>Git push<CR>", "Push" },
      S = { "<cmd>Git<CR>", "Status - Fugitive" },
      g = { "<cmd>lua require('telescope').extensions.gh.gist()<CR>", "Gist" },
      x = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Switch Branch" },
    },
  }
  whichkey.register(keymap, opts)
  require("legendary.integrations.which-key").bind_whichkey(keymap, opts, false)
  -- false if which-key.nvim handles binding them,
  -- set to true if you want legendary.nvim to handle binding
  -- the mappings; if not passed, true by default
  -- false,
  -- )
end

local function visual_keymap()
  local keymap = {
    -- g = {
    --   name = "Git",
    --   y = {
    --     "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
    --     "Link",
    --   },
    -- },
    --
    -- r = {
    --   name = "Refactor",
    --   f = { [[<cmd>lua require('refactoring').refactor('Extract Function')<cr>]], "Extract Function" },
    --   F = {
    --     [[ <cmd>lua require('refactoring').refactor('Extract Function to File')<cr>]],
    --     "Extract Function to File",
    --   },
    --   v = { [[<cmd>lua require('refactoring').refactor('Extract Variable')<cr>]], "Extract Variable" },
    --   i = { [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]], "Inline Variable" },
    --   r = { [[<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>]], "Refactor" },
    --   d = { [[<cmd>lua require('refactoring').debug.print_var({})<cr>]], "Debug Print Var" },
    -- },
  }

  whichkey.register(keymap, v_opts)
  require("legendary.integrations.which-key").bind_whichkey(keymap, v_opts, false)
end

function M.setup()
  normal_keymap()
  visual_keymap()
  -- code_keymap()
end

return M
