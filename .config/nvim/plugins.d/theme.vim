Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'sheerun/vim-polyglot'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'vim-airline/vim-airline'
Plug 'chrisbra/Colorizer'

let g:material_theme_style = 'darker'
colorscheme material

" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" Airline theme
let g:airline_theme = 'material'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:webdevicons_enable_airline_tabline = 0

" Auto highlighting hex colors
let g:colorizer_colornames = 0
let g:colorizer_auto_filetype='css,html,dosini,vim,typescript,typescript.tsx,javascript'

