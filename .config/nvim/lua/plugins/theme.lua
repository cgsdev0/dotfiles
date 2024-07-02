return {
  "tckmn/hotdog.vim",
  { "echasnovski/mini.tabline", version = "*", opts = {

    show_icons = false,
    tabpage_section = "right",
  } },
  -- {
  --   "akinsho/bufferline.nvim",
  --   version = "*",
  --   config = function()
  --     local bufferline = require("bufferline")
  --     bufferline.setup({
  --       options = {
  --         offsets = {
  --           {
  --             separator = false,
  --           },
  --         },
  --         separator_style = "thin",
  --         show_buffer_icons = false,
  --         show_close_icon = false,
  --         show_buffer_close_icons = false,
  --         tab_size = 1,
  --         style_preset = {
  --           bufferline.style_preset.no_italic,
  --           bufferline.style_preset.no_bold,
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      local function read_file(path)
        local file = io.open(path, "rb") -- r read mode and b binary mode
        if not file then
          print("file not found fml")
          return nil
        end
        local content = file:read("*all") -- *a or *all reads the whole file
        file:close()
        return content
      end

      local theme = read_file(os.getenv("HOME") .. "/.theme")

      if theme == nil then
        theme = "tokyonight"
      end

      vim.cmd("colorscheme " .. theme)
    end,
    opts = {
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
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        section_separators = "",
        component_separators = "",
        theme = "tokyonight",
      },
    },
  },
}
