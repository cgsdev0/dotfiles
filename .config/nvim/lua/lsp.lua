require("mason").setup()
require("mason-lspconfig").setup()

require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})

-- vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
-- vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

local border = "rounded"

-- override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["tsserver"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig")["cssls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig")["lua_ls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "require" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
-- local lsp = require('lsp-zero')

-- lsp.preset('recommended')
-- lsp.nvim_workspace()
-- lsp.setup()

-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

-- local cmp = require'cmp'

-- local on_attach = function(client, bufnr)
--   local supports_method = client.supports_method

--   if supports_method("textDocument/completion") then
--     vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--   end

--   local clear_autocmds = vim.api.nvim_clear_autocmds
--   local create_autocmd = vim.api.nvim_create_autocmd

--   if client.name == "eslint" then
--     clear_autocmds({ group = "EslintFixAll", buffer = bufnr })
--     create_autocmd("BufWritePre", {
--       group = "EslintFixAll",
--       buffer = bufnr,
--       command = "EslintFixAll",
--     })
--   end

--   if supports_method("textDocument/formatting") then
--     if client.name == "null-ls" then
--       client.server_capabilities.documentFormattingProvider = true
--       clear_autocmds({ group = "lsp_format", buffer = bufnr })
--       create_autocmd("BufWritePre", {
--         group = "lsp_format",
--         buffer = bufnr,
--         callback = function()
--           require("wuelner.utils").lsp_format(bufnr)
--         end,
--       })
--     else
--       client.server_capabilities.documentFormattingProvider = false
--     end
--   end

--   local keymap_set = vim.keymap.set

--   if supports_method("textDocument/hover") then
--     keymap_set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
--   end

--   if supports_method("textDocument/publishDiagnostics") then
--     keymap_set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
--     keymap_set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })
--     keymap_set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr })
--     keymap_set("n", "<leader>dl", vim.diagnostic.setloclist, { buffer = bufnr })
--   end

--   if supports_method("textDocument/definition") then
--     keymap_set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
--   end

--   if supports_method("textDocument/rename") then
--     keymap_set("n", "<leader>sr", vim.lsp.buf.rename, { buffer = bufnr })
--   end

--   if supports_method("textDocument/codeAction") then
--     keymap_set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
--   end
-- end

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
--   require('lspconfig')['gdscript'].setup {
--     capabilities = capabilities,
--     cmd = vim.lsp.rpc.connect('127.0.0.1', '6008'),
--     on_attach = on_attach,

--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'buffer' },
--   }
--   }

--   local status, null_ls = pcall(require, "null-ls")
-- if (not status) then return end

-- null_ls.setup({
--   sources = {
--     null_ls.builtins.diagnostics.eslint_d.with({
--       diagnostics_format = '[eslint] #{m}\n(#{c})'
--     }),
--     null_ls.builtins.diagnostics.fish
--   }
-- })

-- local status, prettier = pcall(require, "prettier")
-- if (not status) then return end

-- prettier.setup {
--   bin = 'prettierd',
--   filetypes = {
--     "css",
--     "javascript",
--     "javascriptreact",
--     "typescript",
--     "typescriptreact",
--     "json",
--     "scss",
--     "less"
--   }
-- }
