-- Tab set to two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.cmd([[
  augroup packer_user_config

    autocmd!

    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'

  use 'scrooloose/nerdtree'
  use 'ryanoasis/vim-devicons'

  -- colorscheme + aesthetics
  use 'morhetz/gruvbox'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  -- language servers

  -- external tools
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
end)
