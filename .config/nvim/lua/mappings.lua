vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

local bufopts = { noremap = true, silent = true }
vim.keymap.set("n", "<Tab>", ":bnext<CR>", bufopts)
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", bufopts)
vim.keymap.set("n", "<C-w><C-w>", ":bp<bar>bd #<CR>", bufopts)
vim.keymap.set("n", "<CR>", ":noh<CR>", bufopts)
vim.keymap.set("v", "<CR>", "y/\\V<C-R>=escape(@\",'\\/')<CR><CR>", bufopts)
vim.keymap.set("n", "<C-s>", ":w<CR>", bufopts)
vim.keymap.set("n", "<C-\\>", ":vsplit<CR>", bufopts)
vim.keymap.set("n", "<C-N>", ":NvimTreeFindFile!<CR>", bufopts)

local builtin = require("telescope.builtin")
local function control_p_finder()
  builtin.find_files({ layout_strategy = "center" })
end
vim.keymap.set("n", "<C-p>", control_p_finder, bufopts)
vim.keymap.set("n", "<C-g>", ":Telescope live_grep<CR>", bufopts)

-- edit vim config
local function find_config_file()
  require("telescope.builtin").find_files({ cwd = "~/dotfiles/.config/nvim", layout_strategy = "center" })
end
local function grep_config_file()
  require("telescope.builtin").live_grep({ cwd = "~/dotfiles/.config/nvim" })
end
vim.keymap.set("n", "<leader>,", find_config_file, bufopts)
vim.keymap.set("n", "<leader>.", grep_config_file, bufopts)
vim.keymap.set("n", "<leader>T", ":TSPlaygroundToggle<CR>", bufopts)

-- tmux navigation
vim.keymap.set("n", "<C-H>", ":TmuxNavigateLeft<cr>", bufopts)
vim.keymap.set("n", "<C-J>", ":TmuxNavigateDown<cr>", bufopts)
vim.keymap.set("n", "<C-K>", ":TmuxNavigateUp<cr>", bufopts)
vim.keymap.set("n", "<C-L>", ":TmuxNavigateRight<cr>", bufopts)
