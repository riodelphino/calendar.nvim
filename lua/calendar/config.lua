local default_config = {
  keymap = {
    next_month = 'L',
    previous_month = 'H',
    next_day = 'l',
    previous_day = 'h',
    next_week = 'j',
    previous_week = 'k',
    today = 't',
  },
  mark_icon = '•',
  show_adjacent_days = true,
  highlights = {
    current = 'Visual',
    today = 'Todo',
    mark = 'Todo',
    adjacent_days = 'Comment',
  },
  locale = 'en-US',
}

return {
  get = function()
    return default_config
  end,
  setup = function(opt)
    default_config = vim.tbl_deep_extend('force', default_config, opt or {})
  end,
}
