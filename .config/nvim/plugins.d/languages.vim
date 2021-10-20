Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
Plug 'rhysd/vim-clang-format'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

" VS code binds I'm too attached to
map <M-S-o> :CocCommand tsserver.organizeImports<CR>
" map <C-S-p> :CocFzfList<CR>
" Windows terminal hack
map <F6> :CocFzfList<CR>

" Why not?
nnoremap <M-LeftMouse> <LeftMouse>:call CocAction('jumpDefinition')<CR>
nnoremap <C-LeftMouse> <LeftMouse>:call CocAction('jumpDefinition')<CR>
nnoremap <RightMouse> <LeftMouse>:CocFzfList actions<CR>

" ================
" Javascript
" ================
" Jest commands
command! -nargs=0 JestFile :call CocAction('runCommand', 'jest.fileTest', ['%'])
command! -nargs=0 JestSingle :call CocAction('runCommand', 'jest.singleTest')

" ================
" C/C++
" ================

" format on save
autocmd BufWritePre *.c,*.cpp,*.h ClangFormat

" ================
" Python
" ================
let g:python3_host_prog = '/usr/bin/python3'

" ================
" Golang
" ================
" configure vim-go
let g:go_term_enabled = 1
let g:go_term_close_on_exit = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
  \ 'goimports': ' -w -local samsaradev.io',
  \ }
