local M = {}

function M.setup()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.queries.native"] = {},
      ["core.norg.concealer"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      -- ["core.presenter"] = {
      --   -- zen_mode = "truezen",
      -- },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            my_workspace = "~/$DEV_HOME/notes",
          },
        },
      },
    },
  }
end

return M
