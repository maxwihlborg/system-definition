vim.api.nvim_create_user_command("Lcc", function(opts)
  local raw_args = vim.tbl_filter(function(s) return s ~= "" end, vim.split(opts.fargs[1], " "))

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
    on_exit = vim.schedule_wrap(function(j)
      vim.notify(table.concat(j:result(), "\n"), nil, { title = "Output" })
      handle:finish()
    end),
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
      "-n",
      ""
        .. "Write a git commit message for the following. The message "
        .. "starts with a one-line summary of 60 characters, followed by a "
        .. "blank line, followed by a longer but concise description of the "
        .. "change",
    },
    writer = Job:new {
      command = "git",
      args = { "diff", "--staged" },
    },
    on_exit = vim.schedule_wrap(function(j)
      handle:finish()
      local buf = vim.api.nvim_get_current_buf()
      local line_number = vim.api.nvim_win_get_cursor(0)[1]
      vim.api.nvim_buf_set_lines(buf, line_number, line_number, false, j:result())
    end),
  }):start()
end, {})

vim.api.nvim_create_user_command("Ws", function()
  local Job = require "plenary.job"
  Job:new({
    command = "ws-list",
    on_exit = vim.schedule_wrap(function(j)
      vim.ui.select(vim.json.decode(j:result()[1]), {
        prompt = "Select package",
        format_item = function(item) return item.name end,
      }, function(choice)
        if choice ~= nil then
          local dir = vim.fn.escape(choice.dir, " \\")
          vim.cmd(string.format("cd %s", dir))
          vim.cmd(string.format("edit %s/package.json", dir))
        end
      end)
    end),
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
        if #items > 0 then
          vim.fn.setqflist(items)
          vim.cmd.copen()
        else
          vim.fn.setqflist {}
          vim.notify("No lint errors!", nil, { title = "Happy days" })
        end
        handle:finish()
      end)
    end,
  }):start()
end, {})
