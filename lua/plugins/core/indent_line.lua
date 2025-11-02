return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    event = 'VeryLazy', -- Load after everything else
    priority = 500, -- Load after colorschemes but before other UI plugins
    config = function()
      -- Wait a bit to ensure colorscheme is fully loaded
      vim.defer_fn(function()
        -- Create highlight groups before setup
        vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#3B4252', nocombine = true })
        vim.api.nvim_set_hl(0, 'IblScope', { fg = '#88C0D0', nocombine = true })

        require('ibl').setup {
          indent = {
            char = '│',
          },
          scope = {
            enabled = false, -- Disable scope highlighting
          },
        }
      end, 100)
    end,
  },
}
