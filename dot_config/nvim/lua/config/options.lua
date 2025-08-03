-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false
vim.g.snacks_animate = false

vim.g.root_spec = {
  {
    ".git",
    "lua",
    "Makefile",
    "package.json",
    "go.mod",
    "Cargo.toml",
    "build.zig.zon",
    "*.csproj",
  },
  "lsp",
  "cwd",
}

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

vim.o.wrap = true
vim.o.wrapmargin = 4
vim.o.colorcolumn = "80,100,120"
vim.o.cursorcolumn = true
vim.o.listchars = "eol:↵,tab:·┈,trail:·,nbsp:␣,precedes:❮,extends:❯"

vim.o.clipboard = ""
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end

vim.o.spelloptions = "camel,noplainbuffer"

-- vim.lsp.set_log_level("trace")

require("vim.lsp.log").set_format_func(vim.inspect)

vim.filetype.add({
  pattern = {
    [".*/tree-sitter-*/test/corpus/.*\\.txt"] = "test",
  },
})

vim.g.lazyvim_python_lsp = "basedpyright"

vim.treesitter.language.register("c_sharp", "csharp")
