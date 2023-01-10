local M = {}
local nvimtree = require "nvim-tree"
local icons = require "config.ide.icons"

local view = require "nvim-tree.view"

_G.NvimTreeConfig = {}
function NvimTreeConfig.find_toggle()
  if view.is_visible() then
    view.close()
  else
    vim.cmd "NvimTreeToggle"
  end
end

function M.setup()
  require("nvim-web-devicons").setup {
    -- your personnal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    override = {
      zsh = {
        icon = "",
        color = "#428850",
        cterm_color = "65",
        name = "Zsh",
      },
    },
    -- globally enable different highlight colors per icon (default to true)
    -- if set to false all icons will have the default icon's color
    color_icons = true,
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
  }

  nvimtree.setup {
    auto_reload_on_write = true,
    disable_netrw = false,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = false,
    open_on_setup_file = false,
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = true,
    reload_on_bufenter = false,
    respect_buf_cwd = true,
    on_attach = "disable",
    remove_keymaps = false,
    select_prompts = false,
    view = {
      adaptive_size = false,
      centralize_selection = false,
      width = 30,
      hide_root_folder = false,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      mappings = {
        custom_only = false,
        list = {
          -- user mappings go here
        },
      },
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
    renderer = {
      add_trailing = false,
      group_empty = true,
      highlight_git = true,
      full_name = false,
      highlight_opened_files = "all",
      root_folder_label = ":~:s?$?/..?",
      indent_width = 2,
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "before",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        -- glyphs = {
        --   default = icons.ui.File,
        --   symlink = icons.ui.FileSymlink,
        --   bookmark = icons.ui.BookMark,
        --   folder = {
        --     arrow_open = icons.ui.FolderOpen,
        --     arrow_closed = icons.ui.ChevronRight,
        --     default = icons.ui.Folder,
        --     open = icons.ui.FolderOpen,
        --     empty = icons.ui.EmptyFolder,
        --     empty_open = icons.ui.EmptyFolderOpen,
        --     symlink = icons.ui.FileSymlink,
        --     symlink_open = icons.ui.FolderOpen,
        --   },
        --   git = {
        --     unstaged = icons.git.FileUnstaged,
        --     staged = icons.git.FileStaged,
        --     unmerged = icons.git.FileUnmerged,
        --     renamed = icons.git.FileRenamed,
        --     untracked = icons.git.FileUntracked,
        --     deleted = icons.git.FileDeleted,
        --     ignored = icons.git.FileIgnored,
        --   },
        -- },
      },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "*.toml" },
      symlink_destination = true,
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      update_root = false,
      update_cwd = true,
      ignore_list = {},
    },
    ignore_ft_on_setup = {},
    system_open = {
      cmd = "",
      args = {},
    },
    diagnostics = {
      enable = false,
      show_on_dirs = false,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Information,
        warning = icons.diagnostics.Warning,
        error = icons.diagnostics.Error,
      },
    },
    filters = {
      dotfiles = false,
      -- git_clean = false,
      -- no_buffer = false,
      custom = {},
      exclude = {},
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
      ignore_dirs = {},
    },
    git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      show_on_open_dirs = true,
      timeout = 400,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      expand_all = {
        max_folder_discovery = 300,
        exclude = {},
      },
      file_popup = {
        open_win_config = {
          col = 1,
          row = 1,
          relative = "cursor",
          border = "shadow",
          style = "minimal",
        },
      },
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    trash = {
      cmd = "gio trash",
      require_confirm = true,
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true,
    },
    tab = {
      sync = {
        open = false,
        close = false,
        ignore = {},
      },
    },
    notify = {
      threshold = vim.log.levels.INFO,
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
  }
end

return M
