return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "nix",
        "vimdoc",
        "html",
        "markdown",
        "c",
        "lua",
        "vim",
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
      sync_install = false,
      auto_install = false,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    dependencies = {
      {
        "nvim-treesitter/playground",
        cmd = {
          "TSPlaygroundToggle",
          "TSHighlightCapturesUnderCursor",
        },
      },
    },
  },
}
