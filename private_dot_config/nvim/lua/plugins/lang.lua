return {
  { import = "plugins.lang.gherkin" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "css", "html", "make", "kdl", "mermaid", "superhtml", "ziggy" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
      servers = {
        biome = {},
        cssls = {},
        html = {},
        unocss = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("uno.config.ts")(fname)
          end,
        },
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
      local ensure_installed = {
        -- astro = true,
        -- tailwindcss = true,
        -- unocss = true,
        -- volar = true,
        -- vtsls = true,
      }

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
      opts.ensure_installed = {
        -- "markdown-toc",
      }
    end,
  },
}
