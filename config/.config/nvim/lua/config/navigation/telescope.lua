local M = {}

local previewers = require "telescope.previewers"
local Job = require "plenary.job"
local action_layout = require "telescope.actions.layout"
local trouble = require "trouble.providers.telescope"

local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end,
  }):sync()
end

function M.setup()
  require("telescope").load_extension "fzf"
  require("telescope").load_extension "project"
  require("telescope").load_extension "noice"

  local actions = require "telescope.actions"

  require("telescope").setup {
    find_command = { "rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--trim" },
    use_less = true,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    buffer_previewer_maker = new_maker,

    extensions = {
      fzf = {
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      media_files = {
        filetypes = { "png", "jpg", "mp4", "webm", "pdf", "gif" },
      },
      bookmarks = {
        selected_browser = "brave",
        url_open_command = "xdg-open",
        url_open_plugin = "open_browser",
        firefox_profile_name = nil,
      },
    },
    defaults = {
      mappings = {
        i = {
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<M-p>"] = action_layout.toggle_preview,
          ["<C-u>"] = false,
          ["<C-s>"] = actions.cycle_previewers_next,
          ["<C-a>"] = actions.cycle_previewers_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<c-t>"] = trouble.open_with_trouble,
        },
        n = {
          ["<M-p>"] = action_layout.toggle_preview,
          ["<c-t>"] = trouble.open_with_trouble,
        },
      },
    },
  }

  require("telescope").load_extension "attempt"
  require("telescope").load_extension "bookmarks"
  require("telescope").load_extension "neoclip"
  require("telescope").load_extension "zoxide"
  require("telescope").load_extension "repo"
  require("telescope").load_extension "gh"
  require("telescope").load_extension "media_files"
  require("telescope").load_extension "frecency"
  require("telescope").load_extension "file_browser"
  require("telescope").load_extension "projects"
  require("telescope").load_extension "harpoon"

  M.search_dotfiles = function()
    require("telescope.builtin").find_files {
      prompt_title = "< VimRC >",
      cwd = "$HOME/.config/",
    }
  end

  M.switch_projects = function()
    require("telescope.builtin").find_files {
      prompt_title = "< Switch Project >",
      cwd = "$HOME/Github/",
    }
  end

  M.git_branches = function()
    require("telescope.builtin").git_branches {
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<c-d>", actions.git_delete_branch)
        map("n", "<c-d>", actions.git_delete_branch)
        return true
      end,
    }
  end
end

M.project_files = function()
  local opts = { preview_title = "Project Files" } -- define here if you want to define something
  vim.fn.system "git rev-parse --is-inside-work-tree"
  if vim.v.shell_error == 0 then
    opts.show_untracked = true
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

return M
