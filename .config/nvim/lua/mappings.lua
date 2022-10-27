local bufopts = { noremap=true, silent=true }
vim.keymap.set('n', '<Tab>', ':bnext<CR>', bufopts)
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', bufopts)
vim.keymap.set('n', '<C-w><C-w>', ':bp\\|bd #<CR>', bufopts)
vim.keymap.set('n', '<CR>', ':noh<CR>', bufopts)
vim.keymap.set('v', '<CR>', 'y/\\V<C-R>=escape(@",\'\\/\')<CR><CR>', bufopts)
vim.keymap.set('n', '<C-s>', ':w<CR>', bufopts)
vim.keymap.set('n', '<C-\\>', ':vsplit<CR>', bufopts)
vim.keymap.set('n', '<C-N>', ':NERDTreeFind<CR>', bufopts)
vim.keymap.set('n', '<C-p>', ':Files<CR>', bufopts)
