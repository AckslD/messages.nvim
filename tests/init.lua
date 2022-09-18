vim.o.runtimepath = vim.o.runtimepath .. ',./rtps/plenary.nvim'
vim.o.runtimepath = vim.o.runtimepath .. ',.'

require('messages').setup({
  buffer_opts = function(lines)
    return {
      relative = 'editor',
      width = 100,
      height = 10,
      anchor = 'SW',
      row = 0,
      col = 0,
      style = 'minimal',
      border = 'rounded',
      zindex = 1,
    }
  end
})
