local locales = {
  ['en-US'] = {
    -- stylua: ignore
    months = { 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' },
    weekdays = { 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun' },
    year_month = function(year, month, months)
      return string.format('%s %d', months[month], year)
    end,
  },

  ['de-DE'] = {
    -- stylua: ignore
    months = { 'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember', },
    weekdays = { 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So' },
    year_month = function(year, month, months)
      return string.format('%s %d', months[month], year)
    end,
  },

  ['en-GB'] = {
    -- stylua: ignore
    months = { 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' },
    weekdays = { 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun' },
    year_month = function(year, month, months)
      return string.format('%s %d', months[month], year)
    end,
  },

  ['es-ES'] = {
    -- stylua: ignore
    months = { 'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre', },
    weekdays = { 'lun', 'mar', 'mié', 'jue', 'vie', 'sáb', 'dom' },
    year_month = function(year, month, months)
      return string.format('%s %d', months[month], year)
    end,
  },

  ['fr-FR'] = {
    -- stylua: ignore
    months = { 'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre', },
    weekdays = { 'lun', 'mar', 'mer', 'jeu', 'ven', 'sam', 'dim' },
    year_month = function(year, month, months)
      return string.format('%s %d', months[month], year)
    end,
  },

  ['it-IT'] = {
    -- stylua: ignore
    months = { 'gennaio', 'febbraio', 'marzo', 'aprile', 'maggio', 'giugno', 'luglio', 'agosto', 'settembre', 'ottobre', 'novembre', 'dicembre', },
    weekdays = { 'lun', 'mar', 'mer', 'gio', 'ven', 'sab', 'dom' },
    year_month = function(year, month, months)
      return string.format('%s %d', months[month], year)
    end,
  },

  ['ja-JP'] = {
    weekdays = { '月', '火', '水', '木', '金', '土', '日' },
    year_month = function(year, month, _)
      return string.format('%04d 年 %2d 月', year, month)
    end,
  },

  ['ko-KR'] = {
    -- stylua: ignore
    months = { '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월', },
    weekdays = { '월', '화', '수', '목', '금', '토', '일' },
    year_month = function(year, month, _)
      return string.format('%04d년 %2d월', year, month)
    end,
  },

  ['zh-CN'] = {
    weekdays = { '一', '二', '三', '四', '五', '六', '日' },
    year_month = function(year, month, _)
      return string.format('%04d 年 %2d 月', year, month)
    end,
  },

  ['zh-TW'] = {
    weekdays = { '一', '二', '三', '四', '五', '六', '日' },
    year_month = function(year, month, _)
      return string.format('%04d 年 %2d 月', year, month)
    end,
  },

  ['ru-RU'] = {
    -- stylua: ignore
    months = { 'январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль', 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь', },
    weekdays = { 'пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс' },
    year_month = function(year, month, months)
      return string.format('%s %d г.', months[month], year)
    end,
  },
}

return locales
