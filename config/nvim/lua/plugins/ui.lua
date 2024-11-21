return {
  { "stevearc/dressing.nvim" },
  {
    "norcalli/nvim-colorizer.lua",
    lazy = false,
    config = true,
  },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = {
      attach_navic = false,
      show_dirname = false,
      show_modified = false,
      show_basename = false,
      symbols = {
        modified = "●",
        ellipsis = "…",
        separator = "",
      },
      theme = {
        normal = { bg = "#181820" },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require "notify"
      notify.setup {
        background_colour = "#1e2033",
        stages = "static",
      }
      vim.notify = notify
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = {
      "Trouble",
      "TroubleClose",
      "TroubleRefresh",
      "TroubleToggle",
    },
    opts = {
      use_diagnostic_signs = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "nanozuki/tabby.nvim",
    config = function()
      local tabby = require "tabby.tabline"

      local theme = {
        fill = "lualine_c_normal",
        head = "lualine_a_normal",
        current_tab = "lualine_b_normal",
        tab = "lualine_c_normal",
        win = "lualine_c_normal",
        tail = "lualine_c_normal",
      }

      tabby.set(function(line)
        return {
          {
            { "  ", hl = theme.head },
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep("", hl, theme.fill),
              tab.is_current() and "" or "",
              tab.number(),
              tab.name(),
              line.sep("", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
              line.sep("", theme.win, theme.fill),
              win.is_current() and "" or "",
              win.buf_name(),
              hl = theme.win,
              margin = " ",
            }
          end),
          {
            { "  ", hl = theme.tail },
          },
          hl = theme.fill,
        }
      end)
    end,
  },
}
