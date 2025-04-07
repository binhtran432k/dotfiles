return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
  {
    "binhtran432k/dracula.nvim",
    priority = 1000,
    ---@module 'dracula'
    ---@type DraculaConfig
    opts = {
      cache = false,
      on_highlights = function(highlights, colors)
        highlights["@tag.attribute"] = { fg = colors.bright_green, italic = true }
      end,
    },
  },
  { "catppuccin", enabled = false },
}
