return {
  {
    "blink.cmp",
    opts = {
      completion = {
        accept = { auto_brackets = { enabled = false } },
      },
      keymap = {
        preset = "default",
      },
      sources = {
        providers = {
          snippets = {
            opts = {
              extended_filetypes = { typescript = { "javascript" }, typescriptreact = { "javascriptreact" } },
            },
          },
        },
      },
    },
  },
}
