Plug 'kaicataldo/material.vim', { 'branch': 'main' }
let g:material_theme_style = 'darker'

Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'sheerun/vim-polyglot'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/Colorizer'

" Airline theme
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:webdevicons_enable_airline_tabline = 0

" Auto highlighting hex colors
let g:colorizer_colornames = 0
let g:colorizer_auto_filetype='css,html,dosini,vim,typescript,typescript.tsx,javascript'

