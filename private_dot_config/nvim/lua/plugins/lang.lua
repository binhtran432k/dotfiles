return {
  { import = "plugins.lang.gherkin" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "css",
        "editorconfig",
        "html",
        "make",
        "kdl",
        "mermaid",
        "superhtml",
        "ziggy",
      },
    },
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
    "rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            check = { command = "check" },
            -- checkOnSave = false,
          },
        },
      },
    },
  },
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
      },
    },
  },
  {
    "nvim-lint",
    optional = true,
    opts = function(_, opts)
      if opts.linters_by_ft and opts.linters_by_ft.markdown then
        opts.linters_by_ft.markdown = {}
      end
    end,
  },
  {
    "nvim-lspconfig",
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

      local disabled_method_map = {
        ["textDocument/formatting"] = true,
        ["textDocument/rangeFormatting"] = true,
      }
      local origin_supports_method = vim.lsp.client.supports_method
      vim.lsp.client.supports_method = function(self_client, method, ...)
        if disabled_method_map[method] then
          return false
        end
        return origin_supports_method(self_client, method, ...)
      end

    end,
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = {
        -- "markdown-toc",
      }
    end,
  },
}
