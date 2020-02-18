let mapleader = " "

call plug#begin()

" Navigation
Plug 'christoomey/vim-tmux-navigator'

" General development tools
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-abolish'
Plug 'dyng/ctrlsf.vim'
Plug 'prettier/vim-prettier'
Plug 'rhysd/vim-clang-format'
" Go development tools
Plug 'fatih/vim-go', {'for': 'go'}

" Typescript development tools
Plug 'peitalin/vim-jsx-typescript'
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Plug 'Quramy/tsuquyomi'
 " Install nightly build, replace ./install.sh with install.cmd on windows
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
" Or install latest release tag
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
" Or build from source code
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Python development tools
Plug 'davidhalter/jedi-vim', {'for' : 'python'}

" TODO: Explore these
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" Center text
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" File tree browser
Plug 'scrooloose/nerdtree'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Theme plugins
Plug 'dylanaraps/wal.vim'
Plug 'sheerun/vim-polyglot'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'vim-airline/vim-airline'
Plug 'chrisbra/Colorizer'
call plug#end()

colorscheme wal

function! s:make_ticket_url(lines)
  return 'https://samsaradev.atlassian.net/browse/'.substitute(join(a:lines), ':.*', '', '')
endfunction

function! s:upload_picture_and_make_s3_url(lines)
  execute '!upload-picture-s3' join(a:lines)
  return '![image](https://s3.shaneschulte.com/Pictures/'.join(a:lines).')'
endfunction

" Shortcut for inserting a jira ticket
inoremap <expr> <c-x><c-j> fzf#vim#complete(fzf#wrap({
            \ 'source': 'jira mine',
            \ 'reducer': function('<sid>make_ticket_url'),
            \}))

" Shortcut for inserting an image into markdown
inoremap <expr> <c-x><c-i> fzf#vim#complete(fzf#wrap({
            \ 'source': 'pictures',
            \ 'reducer': function('<sid>upload_picture_and_make_s3_url'),
            \}))

" Basic configuration
set number relativenumber
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd Filetype typescrpt.tsx tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype typescrpt tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
set autoindent
set hidden

" Terminal config
tnoremap <Esc> <C-\><C-n>

" Reload vim config
nnoremap <leader>r :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>, :e ~/.config/nvim/init.vim<CR>

" CtrlP config
nnoremap <C-p> :Files<CR>

" Window navigation
" nnoremap <C-H> <C-W><C-H>
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>

" Buffer navigation
nnoremap <Tab> :bnext<CR>
nnoremap <C-N> :NERDTreeFind<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-w><C-w> :bp\|bd #<CR>
nnoremap <C-s> :w<CR>

" CtrlSF Config
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>F <Plug>CtrlSFVwordPath
vmap     <C-F>f <Plug>CtrlSFVwordExec
nmap     <C-F>w <Plug>CtrlSFCwordExec<C-H>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" Powerline theme
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Auto highlighting hex colors
let g:colorizer_colornames = 0
let g:colorizer_auto_filetype='css,html,dosini,vim,typescript'

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :noh<CR>

" Configure jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0

" Configure NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
" prettier autosave
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.graphql,*.md Prettier

autocmd BufWritePre *.cpp,*.h ClangFormat

" configure go
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
  \ 'goimports': ' -w -local samsaradev.io',
  \ }
" let g:go_metalinter_autosave = 1
" let g:go_metalinter_autosave_enabled = ['vet', 'errcheck']
" let g:go_metalinter_enabled = ['vet', 'errcheck']
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
" let g:go_list_type = "quickfix"
autocmd FileType go setlocal tabstop=2|setlocal shiftwidth=2|setlocal softtabstop=2|setlocal noexpandtab
autocmd FileType go compiler go
autocmd FileType go nmap <leader>gd :GoDef<CR>
" let g:syntastic_go_checkers = ['golint', 'govet']

" Configure typescript
"let g:tsuquyomi_disable_default_mappings = 1
let g:coc_node_path = '/usr/bin/node'
"autocmd FileType typescript,typescript.tsx nmap <leader>gd :TsuDefinition<CR>
"autocmd FileType typescript,typescript.tsx setlocal tabstop=2|setlocal shiftwidth=2|setlocal softtabstop=2|setlocal noexpandtab
"let g:tsuquyomi_disable_quickfix = 1
"let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
"autocmd FileType typescript,typescript.tsx nmap <leader>gf :TsuQuickFix<CR>

" Configure syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1

nmap <leader>gn :lnext<CR>
nmap <leader>gp :lprev<CR>

" autocomplete:
set completeopt=noinsert,menuone,noselect

inoremap <C-Space> <C-x><C-o>
" :inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Match i3 split direction
set splitbelow splitright

" Automatically delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Run xrdb whenever XDefaults or Xresources are updated
autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" Custom bindings
map <leader>f :Goyo \| set linebreak<CR>

" Copy to system clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
