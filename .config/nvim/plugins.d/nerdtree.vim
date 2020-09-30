Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

nnoremap <C-N> :NERDTreeFind<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
