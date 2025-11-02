return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  main = "nvim-treesitter.configs", -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

  opts = {
    ensure_installed = {
      "bash",
      "c",
      "css",
      "csv",
      "diff",
      "dockerfile",
      "git_config",
      "gitcommit",
      "gitignore",
      "html",
      "java",
      "javascript",
      "json",
      "latex",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "norg",
      "python",
      "query",
      "regex",
      "rust",
      "scss",
      "svelte",
      "toml",
      "tsx",
      "typst",
      "vim",
      "vimdoc",
      "vue",
      "xml",
      "yaml",
      "zig",
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      foldmethod = "expr",
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { "yaml" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
