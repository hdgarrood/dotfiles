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

-- Syntax highlighting.
vim.cmd('colorscheme flexoki')

-- Make comments stand out by making them italic and brighter
vim.api.nvim_set_hl(0, 'Comment', {fg = '#FFE7CE', italic = true})
vim.api.nvim_set_hl(0, '@comment.documentation', {fg = '#FCC192'})
vim.api.nvim_set_hl(0, '@lsp.mod.documentation', {link = '@comment.documentation'})
vim.api.nvim_set_hl(0, '@lsp.typemod.documentation', {link = '@comment.documentation'})

-- Delimiters and operators should be the same as normal text
for _, hl_group in ipairs({'Delimiter', 'Operator', '@constructor.lua'}) do
  vim.api.nvim_set_hl(0, hl_group, {})
end

-- Different highlighting for different types of literals is bonkers
for _, hl_group in ipairs({'Character', 'Number', 'Float', 'Boolean'}) do
  vim.api.nvim_set_hl(0, hl_group, {link = 'String'})
end

-- keywords don't need a different colour, just make them bold.
-- Different highlighting for different keywords is also bonkers
vim.api.nvim_set_hl(0, 'Keyword', {bold = true})
for _, hl_group in ipairs({'Conditional', 'Repeat', 'Label', 'Exception', 'Conditional'}) do
  vim.api.nvim_set_hl(0, hl_group, {link = 'Keyword'})
end

-- Don't highlight builtins differently
vim.api.nvim_set_hl(0, '@function.builtin', {})

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
  local curl = vim.system({
    'curl', '-fLo', data_dir .. '/autoload/plug.vim', '--create-dirs', 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  })
  curl:wait(10000)
end

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug('nvim-telescope/telescope.nvim', { tag = '*' })
Plug('neovim/nvim-lspconfig')
Plug('nvimtools/none-ls.nvim')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
vim.call('plug#end')

vim.cmd('lsp enable buck2')
vim.cmd('lsp enable rust_analyzer')

-- Set up none-ls / null-ls to format on save with treefmt (if it exists)
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = { null_ls.builtins.formatting.treefmt },
  on_attach = function(client, bufnr)
        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})

-- tree-sitter highlighting
local tree_sitter_languages = {
  'haskell',
  'haskell_persistent',
  'json',
  'nix',
  'python',
  'ruby',
  'rust',
  'starlark',
  'toml',
  'yaml'
}
require('nvim-treesitter').install(tree_sitter_languages)
vim.api.nvim_create_autocmd('FileType', {
  pattern = tree_sitter_languages,
  callback = function() vim.treesitter.start() end,
})
-- Open help vertically by default
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help' },
  callback = function() vim.cmd('wincmd L') end,
})
