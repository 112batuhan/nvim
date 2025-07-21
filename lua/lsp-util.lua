local M = {}

M.custom_on_attach = function(client, bufnr)
  -- Mappings
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  -- Document highlight setup
  if client.server_capabilities.documentHighlightProvider then
    local highlight_augroup = vim.api.nvim_create_augroup("lsp-document-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
      callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "lsp-document-highlight", buffer = event.buf })
      end,
    })
  end

  -- Inlay hints setup (if supported)
  if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    local inlay_hint_group = vim.api.nvim_create_augroup("lsp-inlay-hints", { clear = false })
    vim.lsp.inlay_hint.enable(true, { bufnr })

    -- Toggle inlay hints when entering/leaving insert mode
    vim.api.nvim_create_autocmd("InsertEnter", {
      buffer = bufnr,
      group = inlay_hint_group,
      callback = function()
        vim.lsp.inlay_hint.enable(false, { bufnr })
      end,
    })
    vim.api.nvim_create_autocmd("InsertLeave", {
      buffer = bufnr,
      group = inlay_hint_group,
      callback = function()
        vim.lsp.inlay_hint.enable(true, { bufnr })
      end,
    })
  end
end

return M
