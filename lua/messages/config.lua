local clip_val = require('messages.utils').clip_val

local M = {}

M.settings = {
  command_name = 'Messages',
  border = 'rounded',
  -- should prepare a new buffer and return the winid
  -- by default opens a floating window
  -- provide a different callback to change this behaviour
  -- @param opts: the return value from float_opts
  prepare_buffer = function(opts)
    local buf = vim.api.nvim_create_buf(false, true)
    return vim.api.nvim_open_win(buf, true, opts)
  end,
  -- should return options passed to prepare_buffer
  -- @param lines: a list of the lines of text
  buffer_opts = function(lines)
    local gheight = vim.api.nvim_list_uis()[1].height
    local gwidth = vim.api.nvim_list_uis()[1].width
    return {
      relative = 'editor',
      width = gwidth - 2,
      height = math.floor(clip_val(1, #lines, gheight * 0.5)),
      anchor = 'SW',
      row = gheight - 1,
      col = 0,
      style = 'minimal',
      border = M.settings.border,
      zindex = 1,
    }
  end,
  -- what to do after opening the float
  post_open_float = function(winnr)
  end
}

return M
