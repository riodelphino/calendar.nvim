local M = {}

local marked_days = {}

local function get_key(year, mouth, day)
  return string.format('%4d-%2d-%2d', year, mouth, day)
end

function M.has_marks(year, mouth, day)
  if
    type(year) == 'number'
    and type(mouth) == 'number'
    and type(day) == 'number'
  then
    return marked_days[get_key(year, mouth, day)]
  else
  end
end

function M.mark(year, mouth, day)
  marked_days[get_key(year, mouth, day)] = true
end

return M
