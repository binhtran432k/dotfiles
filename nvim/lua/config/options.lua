-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false

vim.g.root_spec = { { ".git", "lua", "Makefile", "node_modules" }, "lsp", "cwd" }

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

vim.opt.clipboard = ""

vim.opt.formatexpr = ""

vim.opt.spelloptions = "camel,noplainbuffer"
