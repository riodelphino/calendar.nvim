local view = require('calendar.view')

local M = {}

function M.open()
  local t = os.date('*t')
  view.open(t.year, t.month, t.day)
end

function M.complete(lead, comline, cursorpos) end

function M.setup(opt)
  opt = opt or {}

  require('calendar.config').setup(opt)
end

return M
