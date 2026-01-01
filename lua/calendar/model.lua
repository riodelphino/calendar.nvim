local M = {}

function M.month_info(year, month)
  local first_day = os.time({ year = year, month = month, day = 1, hour = 0 })
  local last_day = os.time({ year = year, month = month + 1, day = 0 })

  return {
    first_wday = tonumber(os.date("%w", first_day)),
    days = tonumber(os.date("%d", last_day)),
  }
end

function M.build_month_grid(year, month)
  local info = M.month_info(year, month)
  local grid = {}

  for i = 1, 6 do
    grid[i] = { "  ", "  ", "  ", "  ", "  ", "  ", "  " }
  end

  local start_col = info.first_wday == 0 and 7 or info.first_wday
  local row, col = 1, start_col

  for day = 1, info.days do
    grid[row][col] = string.format("%2d", day)
    col = col + 1
    if col > 7 then
      col = 1
      row = row + 1
    end
  end

  return grid
end

return M
