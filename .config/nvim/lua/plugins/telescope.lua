return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" }, { "MunifTanjim/nui.nvim" } },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          layout_config = {
            horizontal = {
              size = {
                width = "96%",
                height = "96%",
              },
              preview_cutoff = 0,
            },
            center = {
              size = {
                width = "80%",
                height = "60%",
              },
              prompt_position = "bottom",
            },
          },
        },
      })
      telescope.setup({
        defaults = {
          layout_config = {
            horizontal = {
              width = { padding = 0 },
              height = { padding = 0 },
              preview_cutoff = 0,
            },
            center = {
              width = 0.8,
              height = 0.6,
              prompt_position = "bottom",
            },
            -- other layout configuration here
          },
          -- other defaults configuration here
        },
      })
    end,
  },
}
