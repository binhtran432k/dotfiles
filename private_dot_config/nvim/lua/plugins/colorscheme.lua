return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracutux",
    },
  },
  -- {
  --   "binhtran432k/dracula.nvim",
  --   priority = 1000,
  --   ---@module 'dracula'
  --   ---@type DraculaConfig
  --   opts = {
  --     cache = false,
  --     on_highlights = function(highlights, colors)
  --       highlights["@tag.attribute"] = { fg = colors.bright_green, italic = true }
  --     end,
  --   },
  -- },
  {
    "binhtran432k/dracutux.nvim",
    priority = 1000,
    opts = {
      cache = false,
      on_highlights = function(highlights, p)
        -- highlights["SnacksDashboardHeader"] = { fg = p.orange }
      end,
    },
  },
  { "catppuccin", enabled = false },
}
