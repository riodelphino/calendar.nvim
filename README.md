# calendar.nvim

A lightweight calendar plugin for neovim.

[![GitHub License](https://img.shields.io/github/license/wsdjeg/calendar.nvim)](LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/wsdjeg/calendar.nvim)](https://github.com/wsdjeg/calendar.nvim/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/wsdjeg/calendar.nvim)](https://github.com/wsdjeg/calendar.nvim/commits/master/)
[![GitHub Release](https://img.shields.io/github/v/release/wsdjeg/calendar.nvim)](https://github.com/wsdjeg/calendar.nvim/releases)
[![luarocks](https://img.shields.io/luarocks/v/wsdjeg/calendar.nvim)](https://luarocks.org/modules/wsdjeg/calendar.nvim)

<img width="660" height="653" alt="image" src="https://github.com/user-attachments/assets/376a980a-dda6-4317-b0fc-76addfa62c19" />

## ✨ Features

- Monthly calendar view in Neovim
- Vim-style keyboard navigation
- Today highlighting and custom day highlights
- Marked days support
- Extensible architecture
- Configurable setup and keymaps
- Pure Lua, lightweight, no dependencies

## 📦 Installation

```lua
return {
  'wsdjeg/calendar.nvim',
}
```

## 🔧 Configuration

```lua
require('calendar').setup({
  mark_icon = '•',
  -- calendar.nvim support vim style keyboard navigation, hjkl.
  keymap = {
    next_month = 'L',
    previous_month = 'H',
    next_day = 'l',
    previous_day = 'h',
    next_week = 'j',
    previous_week = 'k',
    today = 't',
  },
  highlights = {
    current = 'Visual',
    today = 'Todo',
    mark = 'Todo',
  },
})
```

## 🧩 Custom extensions

calendar.nvim supports extensions which can be used to mark specific date. for example:

here is a simple extension to add [zettelkasten.nvim](https://github.com/wsdjeg/zettelkasten.nvim) support to calendar.nvim

```lua
local zk_ext = {}

function zk_ext.get(year, month)
  local notes = require('zettelkasten.browser').get_notes()
  local marks = {}
  for _, note in ipairs(notes) do
    local t = vim.split(note.id, '-')
    if tonumber(t[1]) == year and tonumber(t[2]) == month then
      table.insert(
        marks,
        {
          year = tonumber(t[1]),
          month = tonumber(t[2]),
          day = tonumber(t[3]),
        }
      )
    end
  end

  return marks
end

require('calendar.extensions').register(zk_ext)
```

## 📣 Self-Promotion

Like this plugin? Star the repository on
GitHub.

Love this plugin? Follow [me](https://wsdjeg.net/) on
[GitHub](https://github.com/wsdjeg).

## 💬 Feedback

If you encounter any bugs or have suggestions, please file an issue in the [issue tracker](https://github.com/wsdjeg/calendar.nvim/issues)

## 🙏 Credits

- [calendar](https://github.com/itchyny/calendar.vim)

## 📄 License

Licensed under GPL-3.0.
