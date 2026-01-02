vim.api.nvim_create_user_command('Calendar', function(opt)
  require('calendar').open(opt.fargs, opt.bang)
end, {
  nargs = '*',
  complete = function(lead, cmdline, cursorpos)
    return require('calendar').complete(lead, cmdline, cursorpos)
  end,
})
