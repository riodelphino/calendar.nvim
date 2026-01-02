# calendar.nvim

A lightweight calendar plugin for neovim.

[![GitHub License](https://img.shields.io/github/license/wsdjeg/calendar.nvim)](LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/wsdjeg/calendar.nvim)](https://github.com/wsdjeg/calendar.nvim/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/wsdjeg/calendar.nvim)](https://github.com/wsdjeg/calendar.nvim/commits/master/)
[![GitHub Release](https://img.shields.io/github/v/release/wsdjeg/calendar.nvim)](https://github.com/wsdjeg/calendar.nvim/releases)
[![luarocks](https://img.shields.io/luarocks/v/wsdjeg/calendar.nvim)](https://luarocks.org/modules/wsdjeg/calendar.nvim)

<img width="660" height="653" alt="image" src="https://github.com/user-attachments/assets/376a980a-dda6-4317-b0fc-76addfa62c19" />

## Installation

```lua
return {
  'wsdjeg/calendar.nvim',
}
```

## Setup

```lua
require('calendar').setup({
  keymap = {
    next_month = 'L',
    previous_month = 'H',
  },
})
```
