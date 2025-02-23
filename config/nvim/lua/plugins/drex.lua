return {
  "TheBlob42/drex.nvim",
  cmd = { "DrexDrawerToggle", "DrexDrawerFindFileAndFocus" },
  keys = {
    { "<c-n>", "<cmd>DrexDrawerToggle<cr>" },
    { "<leader>n", "<cmd>DrexDrawerFindFileAndFocus<cr>" },
  },
  config = function()
    local function quick_look()
      local handle
      local line = vim.api.nvim_get_current_line()
      local path = require("drex.utils").get_element(line)

      handle = vim.loop.spawn("ql", { args = { path } }, function(code)
        ---@diagnostic disable-next-line: need-check-nil
        handle:close()
        if code ~= 0 then
          print "error"
          return
        end
      end)
    end

    local function expand_toggle()
      local elements = require "drex.elements"
      local line = vim.api.nvim_get_current_line()

      if require("drex.utils").is_open_directory(line) then
        elements.collapse_directory()
      else
        elements.expand_element()
      end
    end

    require("drex.config").configure {
      on_enter = function()
        vim.wo.winhighlight = "Normal:NormalSB,SignColumn:SignColumnSB"
        vim.wo.number = false

        vim.wo.winbar = "  %#DrexRoot#~ " .. vim.fn.expand "%:~:.:h:t" .. "%*"
        vim.wo.relativenumber = false
        vim.wo.signcolumn = "no"
      end,
      icons = {
        file_default = "",
        dir_closed = "󰅂",
        dir_open = "󰅀",
        link = "",
        others = "",
      },
      show_hidden = true,
      is_always_hidden = function(name) return name == ".DS_Store" end,
      disable_default_keybindings = true,
      hide_cursor = true,
      keybindings = {
        ["n"] = {
          ["v"] = "V",
          ["l"] = '<cmd>lua require("drex.elements").expand_element()<cr>',
          ["<cr>"] = expand_toggle,
          ["h"] = '<cmd>lua require("drex.elements").collapse_directory()<cr>',
          ["<c-v>"] = '<cmd>lua require("drex.elements").open_file("vs")<cr>',
          ["<c-t>"] = '<cmd>lua require("drex.elements").open_file("tabnew", true)<cr>',
          ["q"] = "<cmd>quit<cr>",
          ["S"] = '<cmd>lua require("drex.actions.stats").stats()<cr>',
          ["a"] = '<cmd>lua require("drex.actions.files").create()<cr>',
          ["d"] = '<cmd>lua require("drex.actions.files").delete("line")<cr>',
          ["D"] = '<cmd>lua require("drex.actions.files").delete("clipboard")<cr>',
          ["p"] = '<cmd>lua require("drex.actions.files").copy_and_paste()<cr>',
          ["P"] = '<cmd>lua require("drex.actions.files").cut_and_move()<cr>',
          ["-"] = quick_look,
          ["r"] = '<cmd>lua require("drex.actions.files").rename()<cr>',
          ["R"] = '<cmd>lua require("drex.actions.files").multi_rename("clipboard")<cr>',
          ["/"] = '<cmd>keepalt lua require("drex.actions.search").search({fuzzy=false})<cr>',
          ["<space>"] = "<cmd>DrexToggle<cr><bar><cmd>call feedkeys('j')<cr>",
          ["<esc>"] = '<cmd>lua require("drex.clipboard").clear_clipboard()<cr>',
          ["c"] = '<cmd>lua require("drex.clipboard").open_clipboard_window()<cr>',
          ["y"] = '<cmd>lua require("drex.actions.text").copy_name()<cr>',
          ["Y"] = '<cmd>lua require("drex.actions.text").copy_relative_path()<cr>',
          ["<c-y>"] = '<cmd>lua require("drex.actions.text").copy_absolute_path()<cr>',
        },
        ["v"] = {
          ["d"] = ':lua require("drex.actions.files").delete("visual")<cr>',
          ["r"] = ':lua require("drex.actions.files").multi_rename("visual")<cr>',
          ["<space>"] = ":DrexToggle<cr>",
          ["y"] = ':lua require("drex.actions.text").copy_name(true)<cr>',
          ["Y"] = ':lua require("drex.actions.text").copy_relative_path(true)<cr>',
          ["<c-y>"] = ':lua require("drex.actions.text").copy_absolute_path(true)<cr>',
        },
      },
    }
  end,
}
