
set background=dark
colorscheme gruvbox
let g:airline_theme = 'base16_gruvbox_dark_hard'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:webdevicons_enable_airline_tabline = 0

lua require('plugins')
lua require('lsp')
lua require('mappings')

