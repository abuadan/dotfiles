local M = {}
local status, cmp = pcall(require, "cmp")
if not status then
  return
end

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local lspkind = require "lspkind"
local luasnip_ = require "luasnip"
local types = require "cmp.types"
local str = require "cmp.utils.str"

-- local t = function(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
local has_words_before = function()
  ---@diagnostic disable-next-line: deprecated
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
-- local has_words_before = function()
--   unpack = unpack or table.unpack
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
-- end

function M.setup()
  cmp.setup {
    view = {
      entries = "custom", -- can be "custom", "wildmenu" or "native"
      selection_order = "near_cursor",
    },
    sources = cmp.config.sources {
      {
        name = "nvim_lsp",
        priority = 8,
        max_item_count = 15,
      },
      {
        name = "luasnip",
        priority = 7,
        max_item_count = 5,
      },
      {
        name = "buffer",
        priority = 7,
        keyword_length = 5,
        max_item_count = 5,
      },
      { name = "neorg" },
      -- {
      --   name = "treesitter",
      --   priority = 5,
      --   max_item_count = 5,
      -- },
      {
        name = "nvim_lua",
        priority = 5,
        max_item_count = 5,
      },
      {
        name = "path",
        priority = 4,
        max_item_count = 5,
      },
    },
    -- sorting = {
    --   priority_weight = 1.0,
    --   comparators = { -- compare.score_offset, -- not good at all
    --     compare.locality,
    --     compare.recently_used,
    --     compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
    --     compare.offset,
    --     compare.order, -- compare.scopes, -- what?
    --     -- compare.sort_text,
    --     -- compare.exact,
    --     -- compare.kind,
    --     -- compare.length, -- useless
    --   },
    -- },
    mapping = cmp.mapping.preset.insert {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-p>"] = cmp.mapping.select_prev_item {
        behavior = cmp.SelectBehavior.Select,
      },
      ["<C-n>"] = cmp.mapping.select_next_item {
        behavior = cmp.SelectBehavior.Select,
      },
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm {
        select = true,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip_.expand_or_jumpable() then
          luasnip_.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
          -- elseif neogen.jumpable() then
          --     neogen.jump_next()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip_.jumpable(-1) then
          luasnip_.jump(-1)
          -- elseif neogen.jumpable(true) then
          --     neogen.jump_prev()
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    formatting = {
      fields = { cmp.ItemField.Abbr, cmp.ItemField.Menu, cmp.ItemField.Kind },
      format = lspkind.cmp_format {
        with_text = true,
        -- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = "...",
        menu = {
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          nvim_lua = "[Lua]",
          path = "[Path]",
          luasnip = "[Snippet]",
          neorg = "[Neorg]",
        },
        before = function(entry, vim_item)
          -- Get the full snippet (and only keep first line)
          local word = entry:get_insert_text()
          if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
            word = vim.lsp.util.parse_snippet(word)
          end
          word = str.oneline(word)

          -- concatenates the string
          local max = 50
          if string.len(word) >= max then
            local before = string.sub(word, 1, math.floor((max - 3) / 2))
            word = before .. "..."
          end

          if
            entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
            and string.sub(vim_item.abbr, -1, -1) == "~"
          then
            word = word .. "~"
          end
          vim_item.abbr = word

          return vim_item
        end,
      },
    },
    snippet = {
      expand = function(args)
        if not luasnip_ then
          return
        end
        luasnip_.lsp_expand(args.body)
      end,
    },
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = true,
    },
  }

  -- Set configuration for specific filetype.
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      {
        name = "cmp_git",
      }, -- You can specify the `cmp_git` source if you were installed it.
    }, { {
      name = "buffer",
    } }),
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { {
      name = "buffer",
    } },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ {
      name = "path",
    } }, { {
      name = "cmdline",
    } }),
  })

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  vim.cmd [[
  highlight! link CmpItemMenu Comment
  highlight! CmpItemKindStruct guifg=#00ff00
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]]
end
return M
