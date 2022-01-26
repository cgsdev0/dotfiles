let mapleader = " "

" Load plugins
runtime plugins.vim

colorscheme wal

" Basic configuration
set number relativenumber
set tabstop=2 softtabstop=0 expandtab shiftwidth=4 smarttab
set autoindent
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Match i3 split direction
set splitbelow splitright

" Automatically delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Run xrdb whenever XDefaults or Xresources are updated
autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" Enable the mouse
set mouse=a

" don't pass messages to |ins-completion-menu|.
set shortmess+=c
set completeopt=noinsert,menuone,noselect

" Make escape exit insert mode in terminal buffers
tnoremap <Esc> <C-\><C-n>

" Reload vim config
nnoremap <leader>r :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>, :e ~/.config/nvim/init.vim<CR>

" Buffer navigation
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-w><C-w> :bp\|bd #<CR>

"This unsets the "last search pattern" register by hitting return
nnoremap <silent> <CR> :noh<CR>
vnoremap <silent> <CR> y/\V<C-R>=escape(@",'/\')<CR><CR>

" I'm a terrible person and I'm not sorry
nnoremap <C-s> :w<CR>
nnoremap <C-\> :vsplit<CR>

