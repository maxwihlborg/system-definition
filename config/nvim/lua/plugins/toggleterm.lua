return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<C-t>", mode = { "n", "i", "v" } },
  },
  init = function()
    local group = vim.api.nvim_create_augroup("CoreToggleTerm", { clear = true })
    vim.api.nvim_create_autocmd("TermOpen", {
      group = group,
      pattern = { "term://*toggleterm#*" },
      callback = function()
        require("pde.utils").load_keymap("terminal", {
          buffer = 0,
        })
      end,
    })
  end,
  opts = {
    open_mapping = "<C-t>",
    shade_terminals = false,
    hide_numbers = true,
    highlights = {
      Normal = { link = "NormalSB" },
      NormalFloat = { link = "NormalFloat" },
      WinBarActive = { link = "TermWinBarActive" },
      WinBarInactive = { link = "TermWinBarInactive" },
    },
    winbar = {
      enabled = true,
      name_formatter = function(term)
        return " " .. term.name .. " "
      end,
    },
  },
}
