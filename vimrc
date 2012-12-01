set nocompatible
call pathogen#infect() 
syntax on 
filetype plugin indent on 

if has("gui_running")
  if has("win32")
    set guifont=consolas:h12
  else
    set guifont=Ubuntu\ Mono\ 13
  endif
  " remove all that gui clutter
  set guioptions-=r
  set guioptions-=T
  set guioptions-=r
  set background=light
  colorscheme solarized
endif

" --- general settings ---
set backspace=indent,eol,start

set hlsearch
set incsearch
set smartcase

set scrolloff=5
set sidescrolloff=5

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" bash-like tab completion
set wildmenu
set wildmode=longest,list

" --- status line stuff ---
"  always show statusline
set laststatus=2
" readonly flag
set statusline=\ \ %r
" line-ending type (dos/unix) and filetype
set statusline+=[%{&ff}/%Y]
" current directory
set statusline+=\ \ %<%-0.40(%{CurDir()}%)
" current cursor position; line and column number
set statusline+=%=%-10.(line\ %l,\ col\ %c%V%)\  

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

" --- custom key mappings ---
" tab navigation like firefox
nmap <C-S-tab> :tabprevious<CR>
nmap <C-tab> :tabnext<CR>
nmap <C-t> :tabnew<CR>

" yanking/pasting to or from other applications
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP

" --- custom functions ---
" increments a global counter, returning its initial value
" increments by value of argument or 1
" useful for search/replace to add list numbers
function! Inc(...)
  let result = g:i
  let g:i += a:0 > 0 ? a:1 : 1
  return result
endfunction

" --- custom commands ---
command! ClearSearchPattern let @/ = ""
