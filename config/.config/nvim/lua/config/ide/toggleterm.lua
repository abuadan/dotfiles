local M = {}
local toggleterm = require "toggleterm"
local Terminal = require("toggleterm.terminal").Terminal

function M.setup()
  toggleterm.setup()
end

--------- Setup Floating Terminal toggles ---------------
--

-- Git client
local git_tui = "lazygit"
-- local git_tui = "gitui"

-- Docker
local docker_lazydocker = "lazydocker"

-- Docker ctop
local docker_ctop = "ctop"

-- navi
local navi = "navi fn welcome"

-- Docker dockly
local docker_dockly = "dockly"

-- Committizen
local git_cz = "git cz"

-- Tokei
local tokei = "tokei"

-- Bottom
local bottom = "btm"

function M.lazygit()
  local git_client = Terminal:new {
    cmd = git_tui,
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "double",
    },
  }
  return git_client:toggle()
end

function M.lazydocker()
  local docker_client = Terminal:new {
    cmd = docker_lazydocker,
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "double",
    },
  }
  return docker_client:toggle()
end

function M.docker_ctop()
  local docker_ctop_client = Terminal:new {
    cmd = docker_ctop,
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "double",
    },
  }
  return docker_ctop_client:toggle()
end

function M.navi()
  local interactive_cheatsheet = Terminal:new {
    cmd = navi,
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "double",
    },
    close_on_exit = false,
  }
  return interactive_cheatsheet:toggle()
end

return M
