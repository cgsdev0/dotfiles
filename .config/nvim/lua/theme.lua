require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"rust",
		"cpp",
		"json",
		"javascript",
		"typescript",
		"tsx",
		"go",
		"bash",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	highlight = {
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

require("tokyonight").setup({
	dim_inactive = false,
	-- transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
	on_highlights = function(hl, c)
		hl.LspDiagnosticsDefaultHint = { fg = c.blue }
		hl.LspDiagnosticsDefaultInformation = { fg = c.blue }
		hl.LspDiagnosticsDefaultWarning = { fg = c.yellow }
		hl.LspDiagnosticsDefaultError = { fg = c.red }
		-- remove telescope background
		hl.TelescopeNormal = { bg = "NONE" }
		hl.TelescopeBorder = { bg = "NONE" }
		hl.TelescopePromptBorder = { bg = "NONE" }
		hl.TelescopeResultsBorder = { bg = "NONE" }
		hl.TelescopePreviewBorder = { bg = "NONE" }
	end,
})
vim.cmd([[colorscheme tokyonight]])

require("lualine").setup({
	options = {
		theme = "tokyonight",
	},
})

require("tabline").setup({
	-- Defaults configuration options
	enable = true,
	options = {
		-- If lualine is installed tabline will use separators configured in lualine by default.
		-- These options can be used to override those settings.
		section_separators = { "", "" },
		component_separators = { "", "" },
		max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
		show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
		show_devicons = true, -- this shows devicons in buffer section
		show_bufnr = false, -- this appends [bufnr] to buffer section,
		show_filename_only = false, -- shows base filename only instead of relative path in filename
		modified_icon = "+ ", -- change the default modified icon
		modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
		show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
	},
})
vim.cmd([[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
    ]])
