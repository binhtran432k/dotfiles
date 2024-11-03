-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
