return {
  { "lewis6991/gitsigns.nvim", config = true },
  { "kdheepak/lazygit.nvim", cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  } },
  { "pwntester/octo.nvim", cmd = "Octo" },
  {
    "aspeddro/gitui.nvim",
    init = function()
      require("core.utils").load_keymap "gitui"
    end,
    opts = {
      command = {
        enable = false,
      },
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
