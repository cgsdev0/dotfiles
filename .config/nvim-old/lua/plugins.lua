vim.cmd([[
  augroup packer_user_config

    autocmd!

    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Packer can manage itself

	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-speeddating")
	use("tpope/vim-abolish")
	use("tpope/vim-commentary")

	use("christoomey/vim-tmux-navigator")
	use("scrooloose/nerdtree")
	use("ryanoasis/vim-devicons")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("nvim-treesitter/playground")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- colorscheme + aesthetics
	use("morhetz/gruvbox")
	use("folke/tokyonight.nvim")
	use("nvim-lualine/lualine.nvim")
	use("kdheepak/tabline.nvim")

	-- language servers
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig") -- Configurations for Nvim LSP
	use("mhartington/formatter.nvim")
	use("folke/neodev.nvim")
	use("mfussenegger/nvim-lint")

	-- auto completion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")

	-- memes
	use("eandrju/cellular-automaton.nvim")
end)
