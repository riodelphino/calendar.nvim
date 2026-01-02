local M = {}

local extensions = {}

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

function M.register(ext)
  table.insert(extensions, ext)
end

function M.on_change(year, month)
  for _, ext in ipairs(extensions) do
    local marks = ext.get(year, month)
    for _, mark in ipairs(marks) do
      M.mark(mark.year, mark.month, mark.day)
    end
  end
end

return M
