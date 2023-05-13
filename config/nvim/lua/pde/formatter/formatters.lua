local M = {}

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

return M
