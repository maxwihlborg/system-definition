local opt = vim.opt

vim.g.mapleader = ","

opt.termguicolors = true
opt.autoindent = true -- Save indentation between lines
opt.backup = false
opt.backupcopy = "yes" -- Saving
opt.belloff = "all" -- No bells
opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.cursorline = true -- Show cursorline
opt.expandtab = true -- Tabs as spaces
opt.guicursor = "a:block-blink0"
opt.hidden = true
opt.inccommand = "nosplit"
opt.incsearch = true
opt.laststatus = 3 -- Global statusbar
opt.showtabline = 2 -- Show tabline
opt.showmode = false
opt.lbr = true
opt.list = true
opt.listchars = { trail = "." } -- Show trailing space
opt.mouse = "a" -- Mouse support
opt.number = true
opt.relativenumber = true -- Hybrid Linenumbers
opt.secure = true
opt.numberwidth = 5
opt.shiftwidth = 2 -- Indentation width
opt.shortmess:append "c"
opt.signcolumn = "yes"
opt.smartindent = true -- C-lang tab indentation
opt.smarttab = true -- Shiftwidth at start of lines
opt.softtabstop = 2 -- <bs> delete 2 space
opt.swapfile = false
opt.tabstop = 2 -- Tabwidth
opt.updatetime = 300
opt.wildmenu = true -- File Explorer settings
opt.wildignore:append ".DS_Store"
opt.wrap = true -- Wordwrap on
opt.writebackup = false

opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Format (:h fo-table)
opt.formatoptions = opt.formatoptions
  - "t" -- Auto-wrap text
  + "c" -- Auto-wrap comments
  + "r" -- Insert comment leader (insert mode)
  - "o" -- Insert comment leader (o, O)
  + "q" -- Format comments with gq
  - "w" -- Trailing white space = paragraph
  - "a" -- Auto format paragraphs
  + "n" -- Auto increment numbered lists
  + "j" -- Remove comment leader when joining lines
  - "2" -- Some weird stuff

opt.joinspaces = false
opt.fillchars = { eob = " " }

local highlightGroup = vim.api.nvim_create_augroup("LuaHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlightGroup,
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 150 }
  end,
})

local group = vim.api.nvim_create_augroup("CoreEditor", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "qf", "help", "dap-float", "chatgpt-input" },
  callback = function(opts)
    require("pde.utils").load_keymap("close", {
      buffer = opts.buf,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "help" },
  callback = function(opts)
    require("pde.utils").load_keymap("help", {
      buffer = opts.buf,
    })
  end,
})

vim.filetype.add {
  extension = {
    gltf = "json",
  },
  filename = {
    [".csharpierrc"] = "jsonc",
    ["flake.lock"] = "jsonc",
  },
}

vim.api.nvim_create_user_command("Lcc", function(opts)
  local raw_args = vim.tbl_filter(function(s)
    return s ~= ""
  end, vim.split(opts.fargs[1], " "))

  local cmd = raw_args[1]
  local cmd_args = {}
  if cmd == "on" then
    cmd_args = { "-o", raw_args[2] }
  elseif cmd == "dim" then
    cmd_args = { "-d", raw_args[2], raw_args[3] }
  elseif cmd == "off" then
    cmd_args = { "-x", raw_args[2] }
  elseif cmd == "list" then
    cmd_args = { "list" }
  elseif cmd == "scene" then
    cmd_args = { "-s", raw_args[2] }
  end

  local progress = require "fidget.progress"
  local Job = require "plenary.job"

  local handle = progress.handle.create {
    title = "Running",
    lsp_client = { name = "lcc" },
  }
  if #cmd_args < 1 then
    vim.notify(opts.fargs[1], vim.log.levels.ERROR, { title = "Invalid Command" })
    return
  end
  Job:new({
    command = "lcc",
    args = cmd_args,
    on_exit = function(j)
      vim.schedule(function()
        vim.notify(j:result(), nil, { title = "Output" })
        handle:finish()
      end)
    end,
  }):start()
end, {
  nargs = 1,
  complete = function(lead, line)
    local valid = { "on", "off", "scene", "list", "dim" }
    local cands = {}
    for _, c in ipairs(valid) do
      if string.find(line, c) then
        return {}
      elseif string.find(c, "^" .. lead) then
        table.insert(cands, c)
      end
    end
    return cands
  end,
})

vim.api.nvim_create_user_command("CommitMsg", function()
  local progress = require "fidget.progress"
  local Job = require "plenary.job"

  local handle = progress.handle.create {
    title = "Generating",
    lsp_client = { name = "cgip" },
  }
  Job:new({
    command = "cgip",
    args = {
      "" -- Source: https://github.com/rtwfroody/gpt-commit-msg/blob/master/gpt_commit_msg.py
        .. "Write a git commit message for the following. The message "
        .. "starts with a one-line summary of 60 characters, followed by a "
        .. "blank line, followed by a longer but concise description of the "
        .. "change",
    },
    writer = Job:new {
      command = "git",
      args = { "diff", "--staged" },
    },
    on_exit = function(j)
      vim.schedule(function()
        handle:finish()
        local buf = vim.api.nvim_get_current_buf()
        local line_number = vim.api.nvim_win_get_cursor(0)[1]
        vim.api.nvim_buf_set_lines(buf, line_number, line_number, false, j:result())
      end)
    end,
  }):start()
end, {})

vim.api.nvim_create_user_command("Lint", function()
  local progress = require "fidget.progress"
  local Job = require "plenary.job"

  local handle = progress.handle.create {
    title = "Lint",
    lsp_client = { name = "eslint" },
  }
  Job:new({
    command = "pnpm",
    args = { "run", "--silent", "lint", "--format=json" },
    on_exit = function(j)
      local items = {}
      for _, result in ipairs(vim.json.decode(j:result()[1])) do
        for _, msg in ipairs(result.messages) do
          table.insert(items, {
            filename = result.filePath,
            text = msg.message,
            type = msg.severity > 1 and "E" or "W",
            lnum = msg.line,
            end_lnum = msg.endLine,
            col = msg.col,
            end_col = msg.endCol,
          })
        end
      end

      table.sort(items, function(a, b)
        if a.type == b.type then
          return false
        end
        return a.type == "E"
      end)

      vim.schedule(function()
        if #items > 1 then
          vim.fn.setqflist(items)
          vim.cmd.copen()
        else
          vim.fn.setqflist {}
          vim.notify("No lint errors!", nil, { title = "All good" })
        end
        handle:finish()
      end)
    end,
  }):start()
end, {})
