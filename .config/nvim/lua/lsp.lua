local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
