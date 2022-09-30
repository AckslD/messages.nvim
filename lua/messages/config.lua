local clip_val = require('messages.utils').clip_val

local M = {}

M.settings = {
  command_name = 'Messages',
  border = 'rounded',
  -- prepare a new buffer and return the winnr and bufnr
  -- by default opens a floating window
  -- provide a different callback to change this behaviour
  -- @param win_opts: the return value from float_opts
  -- @param buf_opts: the buffer local options (filetype, language, etc)
  prepare = function(win_opts, buf_opts)
    -- open a new scratch buffer
    local buf = vim.api.nvim_create_buf(false, true)
    -- set the buffer local options
    for k, v in pairs(buf_opts) do
      vim.api.nvim_buf_set_option(buf, k, v)
    end
    -- open the messages capture window
    local win = vim.api.nvim_open_win(buf, true, win_opts)
    -- return the winnr and bufnr
    return win, buf
  end,
  -- should return options passed to prepare
  -- @param lines: a list of the lines of text
  win_opts = function(lines)
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
  -- should return options passed to prepare
  -- @param lines: a list of the lines of text
  buf_opts = function(lines)
    local _ = lines -- unused parameter
    return {
      filetype = 'messages',
    }
  end,
  -- what to do after opening the float
  post_open_float = function(winnr, bufnr)
    print(string.format('open_float(win=%s,buf=%s)', winnr, bufnr))
  end,
}

return M
