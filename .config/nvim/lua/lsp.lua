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
  vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

local mason_registry = require("mason-registry")
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
  .. "/node_modules/@vue/language-server"

require("lspconfig")["tsserver"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
-- require("lspconfig")["tsserver"].setup({
--   init_options = {
--     plugins = {
--       {
--         name = "@vue/typescript-plugin",
--         location = vue_language_server_path,
--         languages = { "vue" },
--       },
--     },
--   },
--   filetypes = {
--     "javascript",
--     "typescript",
--     "vue",
--   },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   commands = {
--     OrganizeImports = {
--       organize_imports,
--       description = "Organize Imports",
--     },
--   },
-- })

-- require("lspconfig").volar.setup({})

require("lspconfig")["gopls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("lspconfig")["rust_analyzer"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("lspconfig")["cssls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("lspconfig")["biome"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("lspconfig")["clangd"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- local lspconfig = require("lspconfig")
-- local configs = require("lspconfig/configs")

-- if not configs.htmx then
--   configs.htmx = {
--     default_config = {
--       cmd = { "htmx-lsp", "--level", "DEBUG" },
--       root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
--       filetypes = { "sh" },
--       autostart = true,
--     },
--   }
-- end

-- configs.htmx.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

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
