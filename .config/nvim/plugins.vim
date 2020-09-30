call plug#begin()

for f in split(glob('~/.config/nvim/plugins.d/*.vim'), '\n')
    exe 'source' f
endfor

call plug#end()

