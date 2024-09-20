local M = {}

local function create_augroup_memo()
  local cache = {}
  return function(name)
    if not cache[name] then
      cache[name] = vim.api.nvim_create_augroup(name, { clear = true })
    end
    return cache[name]
  end
end

M.get_augroup_memo = create_augroup_memo()

---@param compiler string
---@param opts { pattern: string|table, cmd: string|fun(ev:{file:string}):string }
function M.set_compiler(compiler, opts)
  vim.api.nvim_create_autocmd("FileType", {
    group = M.get_augroup_memo "ProjectConfigCompiler",
    pattern = opts.pattern,
    callback = function(ev)
      vim.schedule(function()
        vim.cmd(string.format("compiler %s", compiler))
        if type(opts.cmd) == "string" then
          vim.opt_local.makeprg = opts.cmd
        else
          vim.opt_local.makeprg = opts.cmd(ev)
        end
      end)
    end,
  })
end

local function resolve_keymap(arg, ...)
  local t = type(arg)
  if t == "table" then
    return arg
  end
  if t == "function" then
    return arg(...)
  end
  if t == "string" then
    return resolve_keymap(require("pde.keymaps")[arg], ...)
  end
  assert(false, "Invalid keymap " .. arg)
end

function M.find_package_json_dir()
  local current_dir = vim.fn.expand "%:p:h" -- Get the directory of the current file

  while current_dir ~= "/" do
    if vim.fn.filereadable(current_dir .. "/package.json") == 1 then
      return current_dir
    end
    current_dir = vim.fn.fnamemodify(current_dir, ":h")
  end

  return nil
end

function M.load_keymap(arg, ...)
  local map = function(mode, keybind, info)
    vim.keymap.set(mode, keybind, info[1], info[2] or {
      noremap = true,
      silent = true,
    })
  end

  local usr_cmd = function(cmd, info)
    vim.api.nvim_create_user_command(cmd, info[1], info[2] or {})
  end

  for mode, mode_values in pairs(resolve_keymap(arg, ...)) do
    for keybind, info in pairs(mode_values) do
      if mode ~= "cmd" then
        map(mode, keybind, info)
      else
        usr_cmd(keybind, info)
      end
    end
  end
end

function M.noop() end

function M.iter(list_or_iter)
  if type(list_or_iter) == "function" then
    return list_or_iter
  end

  return coroutine.wrap(function()
    for i = 1, #list_or_iter do
      coroutine.yield(list_or_iter[i])
    end
  end)
end

function M.reduce(list, memo, func)
  for i in M.iter(list) do
    memo = func(memo, i)
  end
  return memo
end

return M
