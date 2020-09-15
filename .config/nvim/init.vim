let mapleader = " "

call plug#begin()

" Navigation
Plug 'christoomey/vim-tmux-navigator'

" General development tools
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-abolish'
Plug 'rhysd/vim-clang-format'
Plug 'roxma/vim-tmux-clipboard'
" Go development tools

" TODO: Explore these
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" Center text
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Typescript development tools
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}

" File tree browser
Plug 'scrooloose/nerdtree'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Theme plugins
Plug 'peitalin/vim-jsx-typescript'
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

let $FZF_DEFAULT_COMMAND='fd --type f --exclude SamsaraDriver --exclude "npm-packages-offline-cache" --exclude "\.shot" --exclude "*.snap" --exclude "*.shot" --exclude "*.snapshots.json"'
let $RIPGREP_CONFIG_PATH='~/.config/rg/.ripgreprc'

" don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Terminal config
tnoremap <Esc> <C-\><C-n>

" Reload vim config
nnoremap <leader>r :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>, :e ~/.config/nvim/init.vim<CR>

" Global search for this word
nmap <C-F>w :Rg <c-r>=expand("<cword>")<cr><cr>

" Window navigation
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-H> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-J> :TmuxNavigateDown<cr>
nnoremap <silent> <C-K> :TmuxNavigateUp<cr>
nnoremap <silent> <C-L> :TmuxNavigateRight<cr>

" Buffer navigation
nnoremap <Tab> :bnext<CR>
nnoremap <C-N> :NERDTreeFind<CR>
" Gross windows hack lol
nnoremap <F5> :bprevious<CR>
cmap <F5> <S-Tab>
" / hack
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-w><C-w> :bp\|bd #<CR>

" Powerline theme
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Auto highlighting hex colors
let g:colorizer_colornames = 0
let g:colorizer_auto_filetype='css,html,dosini,vim,typescript,typescript.tsx,javascript'

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :noh<CR>

" Configure NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
" prettier autosave
autocmd BufWritePre *.cpp,*.h ClangFormat

" configure go
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
  \ 'goimports': ' -w -local samsaradev.io',
  \ }

" Configure CoC
let g:coc_node_path = '/usr/bin/node'
let g:python3_host_prog = '/usr/bin/python3'

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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" VS code binds
map <M-S-o> :CocCommand tsserver.organizeImports<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-\> :vsplit<CR>
map <F6> :CocFzfList<CR>
nnoremap <C-p> :Files<CR>

" Jest commands
command! -nargs=0 JestFile :call CocAction('runCommand', 'jest.fileTest', ['%'])
command! -nargs=0 JestSingle :call CocAction('runCommand', 'jest.singleTest')

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" autocomplete:
set completeopt=noinsert,menuone,noselect

" Match i3 split direction
set splitbelow splitright

" Automatically delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Run xrdb whenever XDefaults or Xresources are updated
autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" Custom bindings
map <leader>f :Goyo \| set linebreak<CR>

" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction
noremap <silent> <Leader>y y:<C-U>call Yank(@0)<CR>

" automatically run yank(1) whenever yanking in Vim
" (this snippet was contributed by Larry Sanderson)
function! CopyYank() abort
  call Yank(join(v:event.regcontents, "\n"))
endfunction
autocmd TextYankPost * call CopyYank()

" Mouse functionality
set mouse=a
nnoremap <M-LeftMouse> <LeftMouse>:call CocAction('jumpDefinition')<CR>
nnoremap <C-LeftMouse> <LeftMouse>:call CocAction('jumpDefinition')<CR>
nnoremap <RightMouse> <LeftMouse>:CocFzfList actions<CR>

