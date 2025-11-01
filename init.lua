--[[
--
-- Just another neovim config.
--
--]]

vim.g.mapleader = " " -- map leader
vim.g.maplocalleader = "," -- local leader for file type specific commands
vim.g.have_nerd_font = true -- should always have jetbrainsmono

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.o.number = true -- enable line number
vim.o.mouse = "a" -- enable mouse
vim.o.mousehide = true -- hide mouse on typing
vim.o.showmode = false -- no need with status line
vim.o.breakindent = true -- wraps text
vim.o.undofile = true -- undo history
vim.o.ignorecase = true -- allows fzf without casing
vim.o.smartcase = true -- allows capitals to require caps
vim.o.updatetime = 250 -- decrease update time for swap file
vim.o.timeoutlen = 300 -- decrease mapped sequence wait time
vim.o.splitright = true -- how splits open
vim.o.splitbelow = true
vim.o.list = true -- how white space is displayed
vim.opt.listchars = { tab = "»  ", trail = ".", nbsp = "␣" }
vim.o.inccommand = "split" -- preview substitiutions
vim.o.cursorline = true -- what line cursor is on
vim.o.scrolloff = 10 -- minimum lines where cursor can be
vim.o.confirm = true -- prevents accidental missaves
vim.o.expandtab = true -- spaces instead
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Increase window width" })

vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true, desc = "Stay in visual mode while indenting" })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true, desc = "Stay in visual mode while indenting" })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Keybinds to easily open a new terminal
vim.keymap.set("n", "<leader>vt", [[<cmd>vsplit | term<cr>A]], { desc = "Open terminal in vertical split" })
vim.keymap.set("n", "<leader>ht", [[<cmd>split | term<cr>A]], { desc = "Open terminal in horizontal split" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Use jk to enter in terminal normal mode" })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
-- vim.lsp.enable("ocamllsp")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({

  require("plugins.core.guess-indent"),
  require("plugins.core.gitsigns"),
  require("plugins.core.which-key"),
  require("plugins.core.telescope"),
  require("plugins.core.lsp"),
  require("plugins.core.conform"),
  require("plugins.core.blink"),
  require("plugins.core.treesitter"),

  require("plugins.colorschemes.common"),

  require("plugins.utils.debug"),
  require("plugins.utils.indent_line"),
  require("plugins.utils.lint"),
  require("plugins.utils.autopairs"),
  require("plugins.utils.neo-tree"),
  require("plugins.utils.snacks"),

  { import = "plugins.user" },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
