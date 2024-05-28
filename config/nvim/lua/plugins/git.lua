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
    "crnvl96/lazydocker.nvim",
    cmd = "LazyDocker",
    config = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "tpope/vim-fugitive",
    dependencies = {
      { "tommcdo/vim-fubitive" },
      { "tpope/vim-rhubarb" },
    },
  },
}
