return {
  "ThePrimeagen/harpoon",
  lazy = true,
  init = function()
    require("pde.utils").load_keymap "harpoon"
  end,
  opts = {
    menu = {
      width = 80,
    },
  },
}
