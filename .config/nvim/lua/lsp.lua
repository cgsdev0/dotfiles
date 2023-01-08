local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

local cmp = require'cmp'

local on_attach = function(client, bufnr)
  local supports_method = client.supports_method

  if supports_method("textDocument/completion") then
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end

  local clear_autocmds = vim.api.nvim_clear_autocmds
  local create_autocmd = vim.api.nvim_create_autocmd

  if client.name == "eslint" then
    clear_autocmds({ group = "EslintFixAll", buffer = bufnr })
    create_autocmd("BufWritePre", {
      group = "EslintFixAll",
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end

  if supports_method("textDocument/formatting") then
    if client.name == "null-ls" then
      client.server_capabilities.documentFormattingProvider = true
      clear_autocmds({ group = "lsp_format", buffer = bufnr })
      create_autocmd("BufWritePre", {
        group = "lsp_format",
        buffer = bufnr,
        callback = function()
          require("wuelner.utils").lsp_format(bufnr)
        end,
      })
    else
      client.server_capabilities.documentFormattingProvider = false
    end
  end

  local keymap_set = vim.keymap.set

  if supports_method("textDocument/hover") then
    keymap_set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  end

  if supports_method("textDocument/publishDiagnostics") then
    keymap_set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
    keymap_set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })
    keymap_set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr })
    keymap_set("n", "<leader>dl", vim.diagnostic.setloclist, { buffer = bufnr })
  end

  if supports_method("textDocument/definition") then
    keymap_set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
  end

  if supports_method("textDocument/rename") then
    keymap_set("n", "<leader>sr", vim.lsp.buf.rename, { buffer = bufnr })
  end

  if supports_method("textDocument/codeAction") then
    keymap_set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['gdscript'].setup {
    capabilities = capabilities,
    cmd = vim.lsp.rpc.connect('127.0.0.1', '6008'),
    on_attach = on_attach,

  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }
  }
