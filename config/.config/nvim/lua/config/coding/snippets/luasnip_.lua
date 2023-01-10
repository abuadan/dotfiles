local M = {}
local luasnip = require "luasnip"
local types = require "luasnip.util.types"
local snippets_folder = vim.fn.stdpath "config" .. "/lua/config/snippets/snips/"

function M.setup()
  luasnip.config.setup {
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "●", "DiffAdd" } },
        },
      },
      [types.insertNode] = {
        active = {
          virt_text = { { "●", "DiffDelete" } },
        },
      },
    },
  }

  -- Loading any vscode snippets from plugins
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()
  require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }

  -- Load custom typescript snippets
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/typescript" } }
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/angular" } }
  -- require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/python" } }
  -- require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/rust" } }
  luasnip.filetype_extend("all", { "_" })
end

return M
