return {
  { "lewis6991/gitsigns.nvim", config = true },
  { "kdheepak/lazygit.nvim", cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  } },
  {
    "aspeddro/gitui.nvim",
    init = function()
      require("pde.utils").load_keymap "gitui"
    end,
    opts = {
      command = {
        enable = false,
      },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = true,
  },
  {
    "tpope/vim-fugitive",
    dependencies = {
      { "tommcdo/vim-fubitive" },
      { "tpope/vim-rhubarb" },
    },
  },
}
