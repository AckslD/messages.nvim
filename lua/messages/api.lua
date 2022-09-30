local M = {}

local inspect = require('messages.utils').inspect
local settings = require('messages.config').settings

M.open_float = function(text)
  local lines = vim.split(text, '\n')

  local win, buf = settings.prepare(settings.win_opts(lines), settings.buf_opts(lines))

  -- populate the buffer with captured text
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)

  -- invoke the post open callback
  settings.post_open_float(win, buf)

  return win, buf
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
