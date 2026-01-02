local M = {}

local model = require('calendar.model')

local ns = vim.api.nvim_create_namespace('calendar.nvim')
local ext = require('calendar.extensions')

local dot = '•'

local function render_lines(year, month, grid)
  local lines = {}
  table.insert(lines, string.format('              %04d-%02d', year, month))
  table.insert(lines, '                                 ')
  table.insert(lines, '   Mon Tue Wed Thu Fri Sat Sun   ')
  table.insert(lines, '                                 ')

  for _, week in ipairs(grid) do
    table.insert(lines, '   ' .. table.concat(
      vim.tbl_map(function(day)
        if ext.has_marks(year, month, tonumber(day)) then
          return dot .. day
        else
          return ' ' .. day
        end
      end, week),
      ' '
    ))
    table.insert(lines, '                                 ')
  end

  return lines
end
local function highlight_today(buf, year, month, grid)
  local today = os.date('*t')
  if today.year ~= year or today.month ~= month then
    return
  end

  for row, week in ipairs(grid) do
    for col, val in ipairs(week) do
      if tonumber(val) == today.day then
        local line = (row - 1) * 2 + 4
        local col_start, col_end
        if today.day < 10 then
          col_start = (col - 1) * 4 + 4
          col_end = col_start + 3
        else
          col_start = (col - 1) * 4 + 3
          col_end = col_start + 4
        end
        vim.api.nvim_buf_set_extmark(buf, ns, line, col_start, {
          hl_group = 'Visual',
          end_col = col_end,
        })
      end
    end
  end
end

function M.open(year, month)
  local grid = model.build_month_grid(year, month)
  local lines = render_lines(year, month, grid)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].modifiable = false

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    row = 3,
    col = 5,
    width = 35,
    height = #lines,
    style = 'minimal',
    border = 'rounded',
  })
  local winhighlight =
    'NormalFloat:Normal,FloatBorder:WinSeparator,Search:None,CurSearch:None'

  vim.api.nvim_set_option_value('winhighlight', winhighlight, { win = win })

  highlight_today(buf, year, month, grid)

  return buf, win
end

return M
