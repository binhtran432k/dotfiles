return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "[E]xplorer" },
    { "<leader>se", "<cmd>NvimTreeFindFileToggle<cr>", desc = "[S]earch [E]xplorer" },
  },
  init = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    sync_root_with_cwd = true,
  },
}
