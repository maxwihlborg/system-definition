return {
  {
    "TheBlob42/drex.nvim",
    cmd = { "DrexDrawerToggle", "DrexDrawerFindFileAndFocus" },
    init = function()
      require("pde.utils").load_keymap "drex"
    end,
    config = function()
      require("pde.drex").setup()
    end,
  },
}
