--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

local function keyword_pattern(line, trigger_characters)
  -- Pattern is taken from `cmp-emoji` for similar trigger behavior.
  for _, c in ipairs(trigger_characters) do
    local pattern = [=[\%([[:space:]"'`]\|^\)\zs]=] .. c .. [=[[[:alnum:]_\-\+]*]=] .. c .. [=[\?]=] .. "$"
    if vim.regex(pattern):match_str(line) then
      return true
    end
  end
  return false
end

local function get_emojis(self, cb)
  if self._cache then
    cb(self._cache)
    return function() end
  else
    local Job = require "plenary.job"
    local handle = Job:new {
      command = "gh-emoji",
      args = { "json" },
      on_exit = vim.schedule_wrap(function(j) --
        self._cache = vim.json.decode(j:result()[1])
        cb(self._cache)
      end),
    }
    handle:start()
    return function() --
      handle:shutdown()
    end
  end
end

local function get_emoji_info(emoji, cb)
  local Job = require "plenary.job"
  local handle = Job:new {
    command = "gh-emoji",
    args = { "get", "--table", emoji },
    on_exit = vim.schedule_wrap(function(j) --
      cb(vim.fn.join(j:result(), "\n"))
    end),
  }
  handle:start()
  return function() --
    handle:shutdown()
  end
end

function source.new(opts)
  local self = setmetatable({}, { __index = source })
  self.opts = opts
  return self
end

function source:enabled() --
  return vim.tbl_contains({ "markdown", "gitcommit", "jjdescription" }, vim.bo.filetype)
end

function source:get_trigger_characters() --
  return { ":" }
end

function source:get_completions(ctx, cb)
  local cursor_before_line = ctx.line:sub(1, ctx.cursor[2])
  if not keyword_pattern(cursor_before_line, self:get_trigger_characters()) then
    cb()
    return function() end
  else
    return get_emojis(self, function(emojis)
      local kind = require("blink.cmp.types").CompletionItemKind.Text
      local items = vim.tbl_map(
        function(emoji)
          return {
            _data = vim.deepcopy(emoji),
            label = string.format("%s :%s:", emoji.emoji, emoji.name),
            kind = kind,
            textEdit = {
              newText = string.format(":%s:", emoji.name),
              range = {
                ["start"] = {
                  line = ctx.cursor[1] - 1,
                  character = ctx.bounds.start_col - 2,
                },
                ["end"] = {
                  line = ctx.cursor[1] - 1,
                  character = ctx.cursor[2],
                },
              },
            },
          }
        end,
        emojis
      )
      cb {
        items = items,
        is_incomplete_backward = false,
        is_incomplete_forward = false,
      }
    end)
  end
end

function source:resolve(item, callback)
  item = vim.deepcopy(item)
  return get_emoji_info(item._data.name, function(info)
    item.documentation = {
      kind = "markdown",
      value = info,
    }
    callback(item)
  end)
end

return source
