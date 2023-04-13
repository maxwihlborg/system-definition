return {
  "ThePrimeagen/harpoon",
  lazy = true,
  init = function()
    require("core.utils").load_keymap "harpoon"
  end,
  opts = {
    menu = {
      width = 80,
    },
  },
}
