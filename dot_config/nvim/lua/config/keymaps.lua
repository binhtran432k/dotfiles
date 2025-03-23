-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Clipboard keymaps
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "[Y]ank to clipboard" })
vim.keymap.set({ "v" }, "<leader>y", '"+y', { desc = "[Y]ank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]aste from clipboard" })
