return {
  -- COLORSCHEMES
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "folke/tokyonight.nvim",
    -- priority = 1000, -- Make sure to load this before all the other start plugins.
    event = "VeryLazy",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("tokyonight").setup({
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      })

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    end,

    opt = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        float = "transparent",
      },
    },
  },

  {
    "catppuccin/nvim",
    event = "VeryLazy",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("catppuccin").setup({})
    end,
    opt = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        float = "transparent",
      },
    },
  },

  {
    "Mofiqul/dracula.nvim",
    event = "VeryLazy",
    config = function()
      require("dracula").setup({})
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      -- priority = 1000, -- Make sure to load this before all the other start plugins.
      require("gruvbox").setup({})
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
