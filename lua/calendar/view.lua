local M = {}

-- do not create new calendar buffer

local buf = -1
local win = -1

local highlight_today_id = -1

local calendar = {}

local model = require('calendar.model')

local ns = vim.api.nvim_create_namespace('calendar.nvim')
local ext = require('calendar.extensions')

local function render_lines(year, month, grid)
  ext.on_change(year, month)
  local lines = {}
  table.insert(
    lines,
    string.format('              %04d-%02d            ', year, month)
  )
  table.insert(lines, '                                 ')
  table.insert(lines, '   Mon Tue Wed Thu Fri Sat Sun   ')
  table.insert(lines, '                                 ')

  local dot = require('calendar.config').get().mark_icon

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
    ) .. '   ')
    table.insert(lines, '                                 ')
  end

  return lines
end
local function highlight_today(year, month, grid)
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
          hl_group = require('calendar.config').get().highlights.today,
          end_col = col_end,
        })
      end
    end
  end
end

function M.open(year, month)
  calendar.year = year
  calendar.month = month
  calendar.day = 1
  local conf = require('calendar.config').get()
  calendar.grid = model.build_month_grid(year, month)
  calendar.days = calendar.grid.days
  local lines = render_lines(year, month, calendar.grid)
  if not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buftype = 'nofile'
    vim.api.nvim_buf_set_keymap(buf, 'n', conf.keymap.previous_month, '', {
      callback = M.previous_month,
    })
    vim.api.nvim_buf_set_keymap(buf, 'n', conf.keymap.next_month, '', {
      callback = M.next_month,
    })
    vim.api.nvim_buf_set_keymap(buf, 'n', conf.keymap.next_day, '', {
      callback = M.next_day,
    })
    vim.api.nvim_buf_set_keymap(buf, 'n', conf.keymap.previous_day, '', {
      callback = M.previous_day,
    })
    vim.api.nvim_buf_set_keymap(buf, 'n', conf.keymap.next_week, '', {
      callback = M.next_week,
    })
    vim.api.nvim_buf_set_keymap(buf, 'n', conf.keymap.previous_week, '', {
      callback = M.previous_week,
    })
  end
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  if not vim.api.nvim_win_is_valid(win) then
    win = vim.api.nvim_open_win(buf, true, {
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
    vim.api.nvim_set_option_value('sidescrolloff', 0, { win = win })
    vim.api.nvim_set_option_value('scrolloff', 0, { win = win })
  end

  highlight_today(year, month, calendar.grid)

  M.highlight_day(calendar.day)

  return buf, win
end

function M.previous_month()
  if calendar.month == 1 then
    calendar.month = 12
    calendar.year = calendar.year - 1
  else
    calendar.month = calendar.month - 1
  end
  M.open(calendar.year, calendar.month)
end
function M.next_month()
  if calendar.month == 12 then
    calendar.month = 1
    calendar.year = calendar.year + 1
  else
    calendar.month = calendar.month + 1
  end
  M.open(calendar.year, calendar.month)
end

function M.next_day()
  if calendar.day < calendar.days then
    calendar.day = calendar.day + 1
  else
    calendar.day = 1
    M.next_month()
  end
  M.highlight_day(calendar.day)
end

function M.previous_day()
  if calendar.day > 1 then
    calendar.day = calendar.day - 1
  else
    calendar.day = 1
    M.next_month()
  end
  M.highlight_day(calendar.day)
end

function M.next_week()
  if calendar.day + 7 > calendar.days then
    local day = calendar.day + 7 - calendar.days
    M.next_month()
    calendar.day = day
  else
    calendar.day = calendar.day + 7
  end
  M.highlight_day(calendar.day)
end

function M.previous_week()
  if calendar.day <= 7 then
    local day = 7 - calendar.day
    M.previous_month()
    calendar.day = calendar.days - day
  else
    calendar.day = calendar.day - 7
  end
  M.highlight_day(calendar.day)
end

function M.highlight_day(day)
  for row, week in ipairs(calendar.grid) do
    for col, val in ipairs(week) do
      if tonumber(val) == day then
        local line = (row - 1) * 2 + 4
        local col_start, col_end
        if day < 10 then
          col_start = (col - 1) * 4 + 4
          col_end = col_start + 3
        else
          col_start = (col - 1) * 4 + 3
          col_end = col_start + 4
        end
        pcall(vim.api.nvim_buf_del_extmark, buf, ns, highlight_today_id)
        highlight_today_id =
          vim.api.nvim_buf_set_extmark(buf, ns, line, col_start, {
            hl_group = require('calendar.config').get().highlights.current,
            end_col = col_end,
          })
      end
    end
  end
end

return M
