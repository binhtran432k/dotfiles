return {
  { import = "plugins.lang.test" },
  { import = "plugins.lang.gherkin" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "css", "html", "make", "kdl" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {},
        cssls = {},
        html = {},
        omnisharp = {
          cmd = { "OmniSharp" },
        },
        tailwindcss = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "tailwind.config.js",
              "tailwind.config.cjs",
              "tailwind.config.mjs",
              "tailwind.config.ts"
            )(fname)
          end,
        },
        unocss = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- local ensure_installed = {
      --   astro = true,
      --   tailwindcss = true,
      --   unocss = true,
      --   volar = true,
      --   vtsls = true,
      -- }

      local ensure_installed = {}
      for server, server_opts in pairs(opts.servers) do
        if type(server_opts) == "table" and not ensure_installed[server] then
          server_opts.mason = false
        end
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- opts.ensure_installed = { "markdown-toc" }

      opts.ensure_installed = {}
    end,
  },
}
