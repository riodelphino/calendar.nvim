vim.api.nvim_create_user_command("Calendar", function()
  require("calendar").open()
end, {})
