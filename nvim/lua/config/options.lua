-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false

vim.g.root_spec = { { ".git", "lua", "Makefile", "package.json", "go.mod", "cargo.toml" }, "lsp", "cwd" }

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

vim.opt.clipboard = ""

vim.opt.formatexpr = ""

vim.opt.spelloptions = "camel,noplainbuffer"

-- vim.lsp.set_log_level("trace")

require("vim.lsp.log").set_format_func(vim.inspect)

vim.filetype.add({
  pattern = {
    [".*/tree-sitter-*/test/corpus/.*\\.txt"] = "test",
  },
})


vim.g.lazyvim_python_lsp = "basedpyright"
