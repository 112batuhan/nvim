return {
  'petertriho/nvim-scrollbar',
  config = function()
    local scrollbar = require 'scrollbar'
    local colors = require('dracula').colors()
    scrollbar.setup {
      handle = {
        color = colors.fg,
      },
      marks = {
        Search = { color = colors.orange },
        Error = { color = colors.red },
        Warn = { color = colors.yellow },
        Info = { color = colors.blue },
        Hint = { color = colors.cyan },
        Misc = { color = colors.purple },
      },
      handlers = {
        gitsigns = true,
      },
    }
  end,
}
