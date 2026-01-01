local M = {}

function M.render_lines(year, month, grid)
  local lines = {}
  table.insert(lines, string.format('              %04d-%02d', year, month))
  table.insert(lines, '')
  table.insert(lines, '   Mon Tue Wed Thu Fri Sat Sun   ')
  table.insert(lines, '')

  for _, week in ipairs(grid) do
    table.insert(lines, '   ' .. table.concat(week, ' '))
    table.insert(lines, '')
  end

  return lines
end

function M.open(lines)
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

  return buf, win
end

function M.highlight_today(buf, year, month, grid)
  local today = os.date('*t')
  if today.year ~= year or today.month ~= month then
    return
  end

  for row, week in ipairs(grid) do
    for col, val in ipairs(week) do
      if tonumber(val) == today.day then
        local line = (row - 1) * 2 + 4
        local col_start = (col - 1) * 5 + 5
        print(line, col_start)
        vim.api.nvim_buf_add_highlight(
          buf,
          -1,
          'Visual',
          line,
          col_start,
          col_start + 3
        )
      end
    end
  end
end

return M
