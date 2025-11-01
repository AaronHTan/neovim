return {
  "saghen/blink.cmp",
  event = "BufReadPost",
  version = "1.*",
  build = "cargo +nightly build --release",
  dependencies = {
    -- Snippet Engine
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = (function()
        return "make install_jsregexp"
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        -- {
        --   'rafamadriz/friendly-snippets',
        --   config = function()
        --     require('luasnip.loaders.from_vscode').lazy_load()
        --   end,
        -- },
      },
      opts = {},
    },
    "folke/lazydev.nvim",
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ["<C-d>"] = { "scroll_documentation_down" },
      ["<C-u>"] = { "scroll_documentation_up" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      -- Automatically show documentation for the selected item
      documentation = {
        auto_show = true, -- Auto-show documentation
        auto_show_delay_ms = 200, -- Show after 200ms
        window = {
          border = "rounded", -- Optional: nice border for docs
        },
      },

      -- Show completion menu automatically
      menu = {
        enabled = true,
        auto_show = true,
      },

      -- Trigger settings
      keyword = {
        -- Show completions after typing at least 1 character
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "lazydev" },
      providers = {
        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },

    snippets = { preset = "luasnip" },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
  },
}
