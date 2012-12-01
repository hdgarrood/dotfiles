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
  set guioptions-=rTm
  set background=light
  colorscheme solarized
endif

set relativenumber

set backspace=indent,eol,start

" spaces instead of tab chars
set expandtab

" tab width
set tabstop=4
set shiftwidth=4
set softtabstop=4

" wildmenu--bash-like tab completion
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
" end status line stuff

" searching
set hlsearch
set incsearch
set smartcase
" clear search pattern with :C
command! C let @/ = ""

" scrolling
set scrolloff=5
set sidescrolloff=5

" tab navigation like firefox
nmap <C-S-tab> :tabprevious<CR>
nmap <C-tab> :tabnext<CR>
nmap <C-t> :tabnew<CR>

" mappings for yanking/pasting to or from other applications
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP

function! Inc(...)
  let result = g:i
  let g:i += a:0 > 0 ? a:1 : 1
  return result
endfunction
