local M = {}

M.clip_val = function(min, val, max)
  if val < min then
    val = min
  end
  if val > max then
    val = max
  end
  return val
end

-- Mostly the same as vim.pretty_print but returns text
M.inspect = function(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  return table.concat(objects, ", ")
end

return M
