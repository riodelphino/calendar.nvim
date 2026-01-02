local view = require('calendar.view')

local M = {}

function M.open()
  local t = os.date('*t')
  view.open(t.year, t.month)
end

function M.complete(lead, comline, cursorpos)
end

return M
