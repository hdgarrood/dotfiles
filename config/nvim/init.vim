" This is what comments look like
set number
set relativenumber
set colorcolumn=80
set ignorecase
set smartcase
set expandtab
set shiftwidth=2
set scrolloff=5
set wildmode=list:longest
set confirm
colorscheme unokai

" yanking/pasting to/from system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+gP
vnoremap <leader>p "+gP

" yanking/pasting to or from other applications
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+gP
vnoremap <leader>p "+gP

" tabs
nnoremap <leader>t :tabnew<cr>
vnoremap <leader>t :tabnew<cr>

" Highlight trailing space
match TrailingSpace /\s\+$/
highlight link TrailingSpace ColorColumn

" shortcut for clearing the search pattern
command! ClearSearchPattern let @/ = ""
nnoremap <leader><space> :ClearSearchPattern<cr>
vnoremap <leader><space> :ClearSearchPattern<cr>

command! KillWhitespace :normal :%s/\s\+$//g<cr> :ClearSearchPattern

let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Plugins
call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim', { 'tag' : '*' }
Plug 'neovim/nvim-lspconfig'

call plug#end()

lsp enable buck2
lsp enable basedpyright
