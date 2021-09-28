Plug 'roxma/vim-tmux-clipboard'

" " copy to attached terminal using the yank(1) script:
" " https://github.com/sunaku/home/blob/master/bin/yank
" function! Yank(text) abort
"   let escape = system('yank', a:text)
"   if v:shell_error
"     echoerr escape
"   else
"     call writefile([escape], '/dev/tty', 'b')
"   endif
" endfunction
" noremap <silent> <Leader>y y:<C-U>call Yank(@0)<CR>

" " automatically run yank(1) whenever yanking in Vim
" " (this snippet was contributed by Larry Sanderson)
" function! CopyYank() abort
"   call Yank(join(v:event.regcontents, "\n"))
" endfunction
" autocmd TextYankPost * call CopyYank()
