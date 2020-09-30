Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

function! s:make_ticket_url(lines)
  return 'https://samsaradev.atlassian.net/browse/'.substitute(join(a:lines), ':.*', '', '')
endfunction

function! s:upload_picture_and_make_s3_url(lines)
  execute '!upload-picture-s3' join(a:lines)
  return '![image](https://s3.shaneschulte.com/Pictures/'.join(a:lines).')'
endfunction

let $FZF_DEFAULT_COMMAND='fd --type f --exclude SamsaraDriver --exclude "npm-packages-offline-cache" --exclude "\.shot" --exclude "*.snap" --exclude "*.shot" --exclude "*.snapshots.json"'
let $RIPGREP_CONFIG_PATH='~/.config/rg/.ripgreprc'

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

" Global search for this word
nmap <C-F>w :Rg <c-r>=expand("<cword>")<cr><cr>

nnoremap <C-p> :Files<CR>

