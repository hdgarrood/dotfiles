" This is what comments look like
set number
set relativenumber
set colorcolumn=80
set smartcase
set expandtab
set shiftwidth=2
set scrolloff=5
set wildmode=list:longest
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

" Highlight trailing space   
highlight TrailingSpace guibg=#666666
match TrailingSpace /\s\+$/
