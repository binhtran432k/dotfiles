local blink_border = "rounded"

return {
  {
    "blink.cmp",
    opts = {
      cmdline = {
        enabled = true,
        completion = {
          menu = { auto_show = true },
        },
      },
      completion = {
        accept = { auto_brackets = { enabled = false } },
        menu = { border = blink_border },
        documentation = { window = { border = blink_border } },
      },
      signature = { window = { border = blink_border } },
      keymap = {
        preset = "default",
      },
      sources = {
        providers = {
          snippets = {
            opts = {
              global_snippets = { "all", "loremipsum" },
              extended_filetypes = {
                typescript = { "javascript" },
                typescriptreact = { "javascriptreact" },
              },
            },
          },
        },
      },
    },
  },
}
