return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup({})
      -- REQUIRED
      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      vim.keymap.set("n", "<c-t>1", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<C-t>2", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<C-t>3", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<C-t>4", function()
        harpoon:list():select(4)
      end)
      vim.keymap.set("n", "<C-t>5", function()
        harpoon:list():select(5)
      end)
      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():append()
      end)
      vim.keymap.set("n", "<C-e>", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon window" })
    end,
  },
  "christoomey/vim-tmux-navigator",
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      actions = { open_file = { quit_on_open = true } },
    },
  },
}
