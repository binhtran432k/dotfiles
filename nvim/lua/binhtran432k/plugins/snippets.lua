return {
  "garymjr/nvim-snippets",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets", lazy = true },
  keys = {
    -- Think of <c-l> as moving to the right of your snippet expansion.
    --  So if you have a snippet that's like:
    --  function $name($args)
    --    $body
    --  end
    --
    -- <c-l> will move you to the right of each of the expansion locations.
    -- <c-h> is similar, except moving you backwards.
    {
      "<C-l>",
      function()
        if vim.snippet.active({ direction = 1 }) then
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
          return
        end
        return "<C-l>"
      end,
      expr = true,
      silent = true,
      mode = "i",
    },
    {
      "<C-l>",
      function()
        vim.schedule(function()
          vim.snippet.jump(1)
        end)
      end,
      expr = true,
      silent = true,
      mode = "s",
    },
    {
      "<C-h>",
      function()
        if vim.snippet.active({ direction = -1 }) then
          vim.schedule(function()
            vim.snippet.jump(-1)
          end)
          return
        end
        return "<C-h>"
      end,
      expr = true,
      silent = true,
      mode = { "i", "s" },
    },
  },
  opts = {
    friendly_snippets = true,
    extended_filetypes = { typescript = { "javascript" } },
  },
}
