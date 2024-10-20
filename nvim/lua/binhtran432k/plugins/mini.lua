return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  -- event = "VeryLazy",
  lazy = false,
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require("mini.surround").setup({
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    })

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require("mini.statusline")
    -- set use_icons to true if you have a Nerd Font
    statusline.setup({ use_icons = vim.g.have_nerd_font })

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return "%2l:%-2v"
    end

    -- ... and there is mores
    --  Check out: htts://github.com/echasnovski/mini.nvim
    require("mini.jump2d").setup({
      view = { dim = true },
    })

    require("mini.bracketed").setup()

    require("mini.starter").setup()

    require("mini.sessions").setup()

    require("mini.bufremove").setup()

    require("mini.tabline").setup()

    require("mini.pairs").setup()

    require("mini.notify").setup()

    require("mini.cursorword").setup({ delay = 300 })

    require("mini.indentscope").setup({
      draw = { delay = 300, animation = require("mini.indentscope").gen_animation.none() },
    })

    -- Autocmds
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "NvimTree" },
      group = vim.api.nvim_create_augroup("mini-config-nvim-tree", { clear = true }),
      callback = function()
        vim.b.miniindentscope_disable = true
        vim.b.minicursorword_disable = true
        vim.b.ministatusline_disable = true
      end,
    })
  end,
}
