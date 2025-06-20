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
      { "<leader>cg", "<cmd>LazyGit<cr>" },
    },
  },
  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    opts = true,
  },
  {
    "rafikdraoui/jj-diffconflicts",
    cmd = { "JJDiffConflicts" },
  },
  {
    dir = "~/ghq/github.com/maxwihlborg/jjui.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "JJUi" },
    keys = {
      { "<leader>g", "<cmd>JJUi<cr>" },
    },
    opts = true,
  },
}
