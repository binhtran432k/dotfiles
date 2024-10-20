return {
  -- Simulate require
  ---@module 'dracula'
  "binhtran432k/dracula.nvim",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("dracula")
  end,
  ---@type DraculaConfig
  opts = {
    on_highlights = function(highlights, colors)
      highlights["@tag.attribute"] = { fg = colors.bright_green, italic = true }
      highlights.MiniJump2dSpot = { fg = colors.search }
      highlights.MiniJump2dSpotUnique = { fg = colors.search_alt }
      highlights.MiniJump2dDim = { fg = colors.gutter.fg }
    end,
  },
}
