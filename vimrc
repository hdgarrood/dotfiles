set nocompatible
call pathogen#infect()
syntax on
filetype plugin indent on

" --- appearance ---
if has("gui_running")
  if has("win32")
    set guifont=consolas:h12
  else
    set guifont=Terminus\ 12
  endif
  " remove all that gui clutter
  set guioptions-=r
  set guioptions-=T
  set guioptions-=m
  set background=light
else
  set background=dark
endif

colorscheme solarized

" --- general settings ---
set backspace=indent,eol,start
set showcmd
set relativenumber

set hlsearch
set incsearch
set ignorecase
set smartcase

set scrolloff=5
set sidescrolloff=5

set colorcolumn=80

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent

" bash-like tab completion
set wildmenu
set wildmode=longest,list

set directory=~/.vim/_swaps
set backupdir=~/.vim/_backups

set splitright
set splitbelow

" break long lines
set linebreak

" trailing space
set list
set listchars=trail:•

" --- autocommands ---
if has("autocmd")
  augroup all
    autocmd!
    au BufRead,BufNewFile *.\(md\|markdown\) set filetype=markdown
    au BufRead,BufNewFile *.\(pkg\|vw\|ddo\|sbs\|zm\|src\) set filetype=vdf

    au FileType make          set noexpandtab
    au FileType gitcommit     set tw=72 colorcolumn=73
    au FileType markdown      set tw=79
    au FileType ruby,vim,haml set sts=2 sw=2
  augroup END
endif

" --- status line stuff ---
if has("statusline")
  " always show the status bar
  set laststatus=2

  " Start the status line (filename, modified, readonly)
  set statusline=%f\ %m%r

  " Add filetype + eoltype
  set statusline+=[%{&ff}/%Y]

  " Add fugitive
  set statusline+=%{fugitive#statusline()}

  " add present working dir
  set statusline+=\ %5{getcwd()}

  " Finish the statusline
  set statusline+=\ %=Line:%l/%L[%p%%]
  set statusline+=\ Col:%v
  set statusline+=\ Buf:%n
  set statusline+=\ [%b][0x%B]
endif

" --- custom key mappings ---
" tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>

" yanking/pasting to or from other applications
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+gP
vnoremap <leader>p "+gP

" open help in a vertical window
nnoremap <leader>h :vertical help 
vnoremap <leader>h :vertical help 

" shortcut for clearing the search pattern
nnoremap <leader><space> :ClearSearchPattern<cr>
vnoremap <leader><space> :ClearSearchPattern<cr>

" sensible navigation for wrapped lines
nnoremap j gj
nnoremap k gk

" --- custom functions ---
" Increase a number in a column -- use C-v and then C-a
function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>

" --- custom commands ---
command! ClearSearchPattern let @/ = ""
command! KillWhitespace :normal :%s/\s\+$//g<cr> :ClearSearchPattern
