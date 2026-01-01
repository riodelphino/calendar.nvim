local model = require('calendar.model')
local view = require('calendar.view')

local M = {}

function M.open()
  local t = os.date('*t')
  local grid = model.build_month_grid(t.year, t.month)
  local lines = view.render_lines(t.year, t.month, grid)
  local buf = view.open(lines)
  view.highlight_today(buf, t.year, t.month, grid)
end

return M
