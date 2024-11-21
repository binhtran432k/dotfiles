local prettier = "prettierd"

local function smart_fmt(bufnr)
  local has_biome_lsp = vim.lsp.get_clients({
    bufnr = bufnr,
    name = "biome",
  })[1]
  if has_biome_lsp then
    return { "biome" }
  end
  local has_denols = vim.lsp.get_clients({
    bufnr = bufnr,
    name = "denols",
  })[1]
  if has_denols then
    return {}
  end
  local has_prettier = vim.fs.find({
    -- https://prettier.io/docs/en/configuration.html
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
  }, { upward = true })[1]
  if has_prettier then
    return { prettier }
  end
  return { "biome" }
end

return {
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.nix" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.toml" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {},
        cssls = {},
        html = {},
        tailwindcss = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "tailwind.config.js",
              "tailwind.config.cjs",
              "tailwind.config.mjs",
              "tailwind.config.ts",
              "postcss.config.js",
              "postcss.config.cjs",
              "postcss.config.mjs",
              "postcss.config.ts"
            )(fname)
          end,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = smart_fmt,
        graphql = smart_fmt,
        html = { prettier },
        javascript = smart_fmt,
        javascriptreact = smart_fmt,
        json = smart_fmt,
        jsonc = smart_fmt,
        markdown = { prettier },
        nix = { "alejandra" },
        typescript = smart_fmt,
        typescriptreact = smart_fmt,
        yaml = { prettier },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      for _, server_opts in pairs(opts.servers) do
        if type(server_opts) == "table" then
          server_opts.mason = false
        end
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = {}
    end,
  },
}
