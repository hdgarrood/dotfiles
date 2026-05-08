vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.colorcolumn='80'
vim.opt.cursorline=true
vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.expandtab=true
vim.opt.shiftwidth=2
vim.opt.scrolloff=5
vim.opt.wildmode = 'list:longest'
vim.opt.confirm = true

vim.cmd('colorscheme unokai')

-- yanking/pasting to/from system clipboard
vim.keymap.set(
  {'n','v'},
  '<leader>y',
  '"+y',
  { noremap = true }
)
vim.keymap.set(
  {'n','v'},
  '<leader>p',
  '"+gP',
  { noremap = true }
)

-- tabs
vim.keymap.set(
  {'n','v'},
  '<leader>t',
  ':tabnew<cr>',
  { noremap = true }
)

-- Highlight trailing space
vim.cmd('match TrailingSpace /\\s\\+$/')
vim.cmd('highlight link TrailingSpace ColorColumn')

-- shortcut for clearing the search pattern
vim.cmd('command! ClearSearchPattern let @/ = ""')
vim.keymap.set(
  {'n', 'v'},
  '<leader><space>',
  ':ClearSearchPattern<cr>',
  { noremap = true }
)

vim.cmd('command! KillWhitespace :normal :%s/\\s\\+$//g<cr> :ClearSearchPattern')

local data_dir = vim.fn.stdpath('data') .. '/site'
if vim.fn.glob(data_dir .. '/autoload/plug.vim') == "" then
  vim.cmd("silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'")
end

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug('nvim-telescope/telescope.nvim', { tag = '*' })
Plug('neovim/nvim-lspconfig')
Plug('nvimtools/none-ls.nvim')
vim.call('plug#end')

vim.cmd('lsp enable buck2')

local null_ls = require("null-ls")
null_ls.setup({
  sources = { null_ls.builtins.formatting.treefmt }
})
