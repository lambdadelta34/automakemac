local M = {}

function M.run(use)
  use {
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-plenary',
      'nvim-neotest/neotest-vim-test',
      'rouge8/neotest-rust',
      'olimorris/neotest-rspec',
    },
    config = function ()
      require('neotest').setup({
        adapters = {
          require("neotest-plenary"),
          require('neotest-vim-test'),
          require('neotest-rust') {
            args = { '--no-capture' },
          },
          require('neotest-rspec') {
            rspec_cmd = function()
              return vim.tbl_flatten({
                'bundle',
                'exec',
                'rspec',
              })
            end
          },
        },
      })
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        matchup = {
          enable = true
        },
        highlight = {
          enable = true,
          disable = { 'help' },
        },
        indent = {
          enable = true
        },
        endwise = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
      }
    end
  }
end

return M
