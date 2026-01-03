local default_config = {
  keymap = {
    next_month = 'L',
    previous_month = 'H',
    next_day = 'l',
    previous_day = 'h',
  },
}

return {
  get = function()
    return default_config
  end,
  setup = function(opt)
    default_config = vim.tbl_deep_extend('force', default_config, opt or {})
  end,
}
