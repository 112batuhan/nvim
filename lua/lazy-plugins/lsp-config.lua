return {
  -- Mason core
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },

  -- Mason-LSP bridge
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
    },
    opts = {
      ensure_installed = { "lua_ls" },
      automatic_installation = true,
    },
    handlers = {
      -- Disable rust_analyzer so rust-tools.nvim can handle it
      rust_analyzer = function() end,
    },
  },

  -- Mason tool installer (LSPs + formatters + linters)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua_ls",
        "pyright",
        -- Formatters
        "stylua",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000, -- optional delay (ms)
    },
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim", "Snacks" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
        gopls = {},
        pyright = {
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
              },
            },
          },
        },
        -- rust analyser is normally handled by rust-tools
        -- rust_analyzer = {},
        ruff = {
          on_attach = function(client, _)
            if client.name == "ruff" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end,
        },
        --Toml lsp
        taplo = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      for server, config in pairs(opts.servers) do
        -- Merge capabilities with blink.cmp
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)

        local on_attach = require("lsp-util").custom_on_attach
        -- Ensure on_attach is properly set
        if not config.on_attach then
          config.on_attach = on_attach
        else
          local original_on_attach = config.on_attach
          config.on_attach = function(client, bufnr)
            original_on_attach(client, bufnr)
            on_attach(client, bufnr)
          end
        end

        lspconfig[server].setup(config)
      end
    end,
  },
}
