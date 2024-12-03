return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'rust-analyzer' then
          vim.keymap.set('n', '<leader>ee', function()
            vim.cmd.RustLsp { 'renderDiagnostic', 'current' }
          end, { desc = 'Explaining rust errors' })
        end
      end,
    })
  end,
}
