local M = {}

local inspect = require('messages.utils').inspect
local settings = require('messages.config').settings

M.open_float = function(text)
  local lines = vim.split(text, '\n')
  local winnr = settings.prepare_buffer(settings.buffer_opts(lines))
  local bufnr = vim.fn.bufnr()

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
  vim.api.nvim_buf_set_name(bufnr, settings.buffer_name)
  vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'delete')

  settings.post_open_float(winnr)
  return winnr
end

M.capture_thing = function(...)
  M.open_float(inspect(...))
end

M.capture_cmd = function(cmd)
  if cmd == '' then
    cmd = 'messages'
  end

  M.open_float(vim.api.nvim_exec(cmd, true))
end

return M
