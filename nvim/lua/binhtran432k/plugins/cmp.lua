return {
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim",
    },
    config = function()
      -- See `:help cmp`
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local cmp_float_window = cmp.config.window.bordered({
        winhighlight = "CursorLine:Visual,Search:None",
      })
      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },

        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = function()
                return math.min(math.floor(0.6 * vim.o.columns), 50)
              end, -- leading text (labelDetails)
              abbr = 50, -- actual suggestion item
            },
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ["<C-Space>"] = cmp.mapping.complete({}),
        }),
        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "snippets" },
          { name = "path" },
          { name = "buffer", group_index = 2 },
        },
        window = {
          completion = cmp_float_window,
          documentation = cmp_float_window,
        },
      })
    end,
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    config = function()
      local cmp = require("cmp")
      local cmdline_mapping = cmp.mapping.preset.cmdline({
        -- Select the [n]ext item
        ["<C-n>"] = { c = cmp.mapping.select_next_item() },
        -- Select the [p]revious item
        ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
        -- Manually trigger a completion from nvim-cmp.
        ["<C-Space>"] = cmp.mapping.complete({}),
      })

      -- `/` cmdline setup.
      for _, key in ipairs({ "/", "?" }) do
        cmp.setup.cmdline(key, {
          mapping = cmdline_mapping,
          sources = { { name = "buffer" } },
        })
      end

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmdline_mapping,
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = { ignore_cmds = { "Man", "!" } },
          },
        }),
      })
    end,
  },
}
