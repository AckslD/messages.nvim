local M = {}

local update_config = function(opts)
  local config = require('messages.config')
  opts = opts or {}
  config.settings = vim.tbl_extend('force', config.settings, opts)
end

local create_commands = function()
  local command_name = require('messages.config').settings.command_name
  vim.api.nvim_create_user_command(command_name, function(opts)
    require('messages.api').capture_cmd(opts.args)
  end, {
    nargs = '*',
    desc = 'messages.nvim (capture cmd)',
    complete = 'command',
  })
end

M.setup = function(opts)
  update_config(opts)
  create_commands()
end

return M
