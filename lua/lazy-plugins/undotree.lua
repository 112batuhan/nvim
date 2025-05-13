return {
  'jiaoshijie/undotree',
  dependencies = 'nvim-lua/plenary.nvim',
  config = {
    position = 'right',
    winblend = 100,
    keymaps = {
      ['<down>'] = 'move_change_next',
      ['<up>'] = 'move_change_prev',
    },
  },
  keys = { -- load the plugin only when using it's keybinding:
    { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
  },
}
