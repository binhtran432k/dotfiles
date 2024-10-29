local prettier = "prettierd"

local function biome_lsp_or_prettier(bufnr)
  local has_biome_lsp = vim.lsp.get_clients({
    bufnr = bufnr,
    name = "biome",
  })[1]
  if has_biome_lsp then
    return { "biome" }
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

return { -- Autoformat
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v", "x" },
      desc = "Code [F]ormat",
    },
  },
  opts = {
    notify_on_error = false,
    -- format_on_save = function(bufnr)
    --   -- Disable "format_on_save lsp_fallback" for languages that don't
    --   -- have a well standardized coding style. You can add additional
    --   -- languages here or re-enable it for the disabled ones.
    --   local disable_filetypes = { c = true, cpp = true, zig = true }
    --   local lsp_format_opt
    --   if disable_filetypes[vim.bo[bufnr].filetype] then
    --     lsp_format_opt = "never"
    --   else
    --     lsp_format_opt = "fallback"
    --   end
    --   return {
    --     timeout_ms = 500,
    --     lsp_format = lsp_format_opt,
    --   }
    -- end,
    formatters_by_ft = {
      lua = { "stylua" },
      nix = { "alejandra" },
      javascript = biome_lsp_or_prettier,
      typescript = biome_lsp_or_prettier,
      javascriptreact = biome_lsp_or_prettier,
      typescriptreact = biome_lsp_or_prettier,
      json = biome_lsp_or_prettier,
      jsonc = biome_lsp_or_prettier,
      css = { prettier },
      html = { prettier },
      yaml = { prettier },
      markdown = { prettier },
      graphql = { prettier },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
    },
  },
}
