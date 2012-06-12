set nocompatible
call pathogen#infect() 
syntax on 
filetype plugin indent on 

if has("gui_running")
  if has("win32")
    set guifont=inconsolata:h12
  else
    set guifont=Ubuntu\ Mono\ 13
  endif
  set guioptions-=r
  set guioptions-=T
  set background=dark
  colorscheme solarized
endif

set relativenumber
set ruler

set backspace=indent,eol,start

" spaces instead of tab chars
set expandtab

" tab width
set tabstop=4
set shiftwidth=4
set softtabstop=4

" wildmenu
set wildmenu
set wildchar=<TAB>

" status line stuff
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
set statusline+=\ \ \ [%{&ff}/%Y]
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L


function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction
" end status line stuff

" searching
set incsearch
set ignorecase

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
