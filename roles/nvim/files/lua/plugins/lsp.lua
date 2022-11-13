local M = {}

function M.run(use)
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')

      -- lsp.set_preferences({
      --   set_lsp_keymaps = false
      -- })
      lsp.on_attach(function(client, bufnr)
        -- local opts = { buffer = bufnr, remap = false }
        -- local bind = vim.keymap.set

        -- bind("n", "<leader>f", vim.lsp.buf.formatting, opts)
        -- bind('n', "gr", "<cmd>TroubleToggle quickfix<cr>", opts)
        -- bind('n', '<space>rn', vim.lsp.buf.rename, opts)
        -- bind('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        -- bind('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', noremap)
      end)

      local navic = require("nvim-navic")
      require("lspconfig").clangd.setup {
        on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
        end
      }

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local sources = lsp.defaults.cmp_sources()
      table.insert(sources, { name = 'nvim_lsp_signature_help' })

      local cmp_config = lsp.defaults.cmp_config({
        sources = sources,
        mapping = {
          ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
        },
      })

      cmp.setup(cmp_config)

      lsp.nvim_workspace()
      lsp.setup()
    end
  }
end

return M
