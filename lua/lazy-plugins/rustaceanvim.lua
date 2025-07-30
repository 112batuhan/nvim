return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "rust-analyzer" then
          vim.keymap.set("n", "<leader>re", function()
            vim.cmd.RustLsp({ "renderDiagnostic", "current" })
          end, { desc = "Explaining rust errors" })
        end
        require("lsp-util").custom_on_attach(client, args.buf)
      end,
    })
  end,
  server = {
    cmd = function()
      local mason_registry = require("mason-registry")
      if mason_registry.is_installed("rust-analyzer") then
        -- This may need to be tweaked depending on the operating system.
        local ra = mason_registry.get_package("rust-analyzer")
        local ra_filename = ra:get_receipt():get().links.bin["rust-analyzer"]
        return { ("%s/%s"):format(ra:get_install_path(), ra_filename or "rust-analyzer") }
      else
        -- global installation
        return { "rust-analyzer" }
      end
    end,
  },
}
