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
      height = clip_val(1, #lines, gheight * 0.5),
      anchor = 'SW',
      row = gheight - 1,
      col = 0,
      style = 'minimal',
      border = 'rounded',
      zindex = 1,
    }
  end,
  -- what to do after opening the float
  post_open_float = function(winnr)
  end
})
```

## Credit
@AndrewRadev for creating https://github.com/AndrewRadev/bufferize.vim which inspired this.
