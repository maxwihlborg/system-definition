return {
  { "lewis6991/gitsigns.nvim", config = true },
  { "tpope/vim-fugitive" },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>g", "<cmd>LazyGit<cr>" },
    },
  },
  {
    "crnvl96/lazydocker.nvim",
    cmd = "LazyDocker",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>cd", "<cmd>LazyDocker<cr>" },
    },
  },
  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    opts = true,
  },
  {
    dir = "~/ghq/github.com/maxwihlborg/jjui.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "JJUi" },
    keys = {
      { "<leader>cj", "<cmd>JJUi<cr>" },
    },
    opts = true,
  },
}
