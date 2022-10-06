# messages.nvim
Capture and show any messages in a customisable (floating) buffer.

![gscreenshot_2022-09-18-134000](https://user-images.githubusercontent.com/23341710/190900297-3914fddd-cf39-49b1-b870-642b80b389f1.png)

## Installation
For example using [`packer`](https://github.com/wbthomason/packer.nvim):
```lua
use {
  'AckslD/messages.nvim',
  config = 'require("messages").setup()',
}
```

## Usage
Prefix and command with `Messages`, for example:
```
:Messages messages
```

You can also pass any lua object to `require('messages.api').capture_thing`. A tip is to add the following global function in your config:
```lua
Msg = function(...)
  require('messages.api').capture_thing(...)
end
```
Then you can do for example
```
:lua Msg(vim.lsp)
```

## Configuration
Pass a dictionary into `require("messages").setup()` with callback functions.
These are the defaults:
```lua
require('messages').setup({
  command_name = 'Messages',
  border = 'rounded',
  -- prepare a new buffer and return the winnr and bufnr
  -- by default opens a floating window
  -- provide a different callback to change this behaviour
  -- @param window_opts: the return value from float_opts
  -- @param bufdow_opts: the buffer local options (filetype, language, etc)
  prepare = function(window_opts, buffer_opts)
    -- open a new scratch buffer
    local buf = vim.api.nvim_create_buf(false, true)
    -- set the buffer local options
    for k, v in pairs(buffer_opts) do
      vim.api.nvim_buf_set_option(buf, k, v)
    end
    -- open the messages capture window
    local win = vim.api.nvim_open_win(buf, true, window_opts)
    -- return the winnr and bufnr
    return win, buf
  end,
  -- should return options passed to prepare
  -- @param lines: a list of the lines of text
  window_opts = function(lines)
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
  buffer_opts = function(lines)
    local _ = lines -- unused parameter
    return {
      filetype = 'messages',
    }
  end,
  -- what to do after opening the float
  post_open_float = function(winnr, bufnr)
    local _ = winnr -- unused parameter
    local _ = bufnr -- unused parameter
    -- print(string.format('open_float(win=%s,buf=%s)', winnr, bufnr))
  end,
})
```

## Credit
@AndrewRadev for creating https://github.com/AndrewRadev/bufferize.vim which inspired this.
