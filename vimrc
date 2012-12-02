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
set showcmd

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

set directory=~/.vim/_swaps
set backupdir=~/.vim/_backups

" --- autocommands ---
if has("autocmd")
    au BufRead,BufNewFile *.\(md\|markdown\) setf markdown

    au FileType make set noexpandtab
    au FileType gitcommit,markdown set tw=72
    au FileType ruby set sts=2 sw=2
endif

" --- status line stuff ---
if has("statusline")
    " always show the status bar
    set laststatus=2

    " Start the status line (filename, modified, readonly)
    set statusline=%f\ %m\ %r

    " Add filetype + eoltype
    set statusline+=\ [%{&ff}/%Y]

    " Add fugitive
    set statusline+=\ %{fugitive#statusline()}

    " Finish the statusline
    set statusline+=%=Line:%l/%L[%p%%]
    set statusline+=\ Col:%v
    set statusline+=\ Buf:%n
    set statusline+=\ [%b][0x%B]
endif

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
command! KillWhitespace :normal :%s/\s\+$//g<cr> :ClearSearchPattern
