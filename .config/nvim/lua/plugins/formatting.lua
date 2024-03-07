return {
  "mhartington/formatter.nvim",
  lazy = false,
  config = function()
    local util = require("formatter.util")
    require("formatter").setup({
      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
      -- All formatter configurations are opt-in
      filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
          require("formatter.filetypes.lua").stylua,
          function()
            return {
              exe = "stylua",
              args = {
                "--column-width",
                "120",
                "--indent-type",
                "Spaces",
                "--indent-width",
                "2",
                "--search-parent-directories",
                "--stdin-filepath",
                util.escape_path(util.get_current_buffer_file_path()),
                "--",
                "-",
              },
              stdin = true,
            }
          end,
        },
        css = {
          require("formatter.filetypes.css").prettier,
        },
        json = {
          require("formatter.filetypes.json").prettier,
        },
        go = {
          require("formatter.filetypes.go").gofmt,
          require("formatter.filetypes.go").goimports,
        },
        javascript = {
          require("formatter.filetypes.javascript").prettier,
        },
        javascriptreact = {
          require("formatter.filetypes.javascriptreact").prettier,
        },
        typescript = {
          require("formatter.filetypes.typescript").prettier,
        },
        typescriptreact = {
          require("formatter.filetypes.typescriptreact").prettier,
        },
        rust = {
          require("formatter.filetypes.rust").rustfmt,
        },
        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
          -- "formatter.filetypes.any" defines default configurations for any
          -- filetype
          require("formatter.filetypes.any").remove_trailing_whitespace,
        },
      },
    })

    local formatGroup = vim.api.nvim_create_augroup("FormatAutogroup", {})
    vim.api.nvim_create_autocmd("BufWritePost", {
      command = "FormatWriteLock",
      group = formatGroup,
    })
  end,
}
