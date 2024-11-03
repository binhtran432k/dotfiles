return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  keys = {
    { "]h", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Hunk" },
    { "[h", "<cmd>Gitsigns prev_hunk<cr>", desc = "Next Hunk" },
    { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "[H]unk [P]review" },
    { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", desc = "[H]unk [S]tage" },
    { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", desc = "[H]unk [R]eset" },
    { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "[H]unk [U]ndo" },
  },
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    signs_staged_enable = false,
  },
}
