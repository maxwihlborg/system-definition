local M = {}

function M.lsp_formatting()
  return {
    name = "lsp-format",
    exe = function(opts)
      print(vim.inspect(opts))
    end,
    exe2 = function(opts)
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_active_clients {
        bufnr = bufnr,
      }

      for client_id, client in pairs(clients) do
        local method = "textDocument/formatting"
        local timeout_ms = 2000
        local res = client.request_sync(method, {}, timeout_ms, bufnr) or {}

        -- This is a caught by the caller
        assert(res.err == nil, string.format("LSP %s returned an error %s", client.name or string.format("client_id=%d", client_id), tostring(res.err)))

        if res == nil then
          -- No formatting applied
          return
        end

        -- Success, we had formatting to apply, apply it to the buffer
        vim.lsp.util.apply_text_edits(res.result, bufnr, "utf-16")

        if opts.write then
          -- Run on the buffer we were given in case the user changed whilst the formatter was running
          vim.api.nvim_buf_call(bufnr, function()
            -- :update is like :w but only if there's changes present
            vim.cmd [[ update ]]
          end)
        end
      end
    end,
  }
end

function M.sql_formatter()
  return {
    exe = "sql-formatter",
    args = {
      "-c",
      vim.fn.expand "~/.config/sql-formatter/config.json",
    },
    stdin = true,
  }
end

function M.rescript_fmt()
  local util = require "formatter.util"

  return {
    exe = "./node_modules/.bin/rescript",
    args = {
      "format",
      "-stdin",
      util.escape_path(util.get_current_buffer_file_path()),
    },
    stdin = true,
  }
end

function M.prettier()
  local util = require "formatter.util"

  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      util.escape_path(util.get_current_buffer_file_path()),
    },
    stdin = true,
    try_node_modules = true,
  }
end

function M.rome()
  local util = require "formatter.util"

  return {
    exe = "rome",
    args = {
      "format",
      "--stdin-file-path",
      util.escape_path(util.get_current_buffer_file_path()),
    },
    stdin = true,
  }
end

local function setupFormatter()
  local status_ok, formatter = pcall(require, "formatter")
  if not status_ok then
    return
  end

  local formatterConfig = {
    -- haxe = { require("max.pde.formatter.haxe").formatter },
    fish = { require("formatter.filetypes.fish").fishindent },
    glsl = { require("formatter.filetypes.c").clangformat },
    rust = { require("formatter.filetypes.rust").rustfmt },
    css = { require("formatter.filetypes.css").prettier },
    lua = { require("formatter.filetypes.lua").stylua },
    nix = { require("formatter.filetypes.nix").nixpkgs_fmt },
    -- html = { require("formatter.filetypes.html").htmlbeautify },
    -- typescript = { M.rome },
    -- prisma = { M.lsp_formatting },
    rescript = { M.rescript_fmt },
    sql = { M.sql_formatter },
  }

  local util = require "formatter.util"

  local commonFT = {
    "css",
    "scss",
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "markdown",
    "markdown.mdx",
    "graphql",
    "json",
    "yaml",
    "xml",
    "svelte",
  }

  for _, ft in ipairs(commonFT) do
    formatterConfig[ft] = { util.withl(require "formatter.defaults.prettier") }
  end

  formatter.setup {
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = formatterConfig,
  }
end

local function setupAutocmds()
  local group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    command = "FormatWrite",
    group = group,
  })
end

function M.init()
  setupAutocmds()
end

function M.setup()
  setupFormatter()
end

return M
