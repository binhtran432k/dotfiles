return {
  {
    "snacks.nvim",
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      picker = {
        sources = { files = { hidden = true }, explorer = { hidden = true } },
        win = {
          input = {
            keys = {
              ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            },
          },
        },
      },
      dashboard = {
        preset = {
          --           header = [[
          -- 
          -- ████
          -- ]],
          --           header = [[
          --     
          -- ██
          -- ████
          -- ██
          --      ]],
          header = [[
                                                           Z
      █████                      ████     ██         z  
     █████                        ████                   
     ███   ███ ███████████████████ ██  █████ 
    ███    ████     ██  ███████████ ███ ████████ 
   ███    ████   ██    ████████████ ███ ███ ██ ███ 
 █████████     ██ ██         ██ █████ ███ ███ ██ ███ 
███████████████████████████████  ███ ███ ███ ██ ███]],
        },
      },
    },
  },
  {
    "noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "lualine.nvim",
    opts = {
      options = {
        -- component_separators = { left = "│", right = "│" },
        -- section_separators = { left = "", right = "" },
      },
    },
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    event = { "VeryLazy" },
    config = function()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require("rainbow-delimiters")

      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          query = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterCyan",
          "RainbowDelimiterBlue",
          "RainbowDelimiterViolet",
        },
      }
    end,
  },
}
