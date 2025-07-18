return {
  {
    "snacks.nvim",
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      scroll = { enabled = false },
      indent = { animate = { enabled = false } },
      picker = {
        sources = { files = { hidden = true }, explorer = { hidden = true } },
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
    "bufferline.nvim",
    opts = {
      options = {
        separator_style = "slant",
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
