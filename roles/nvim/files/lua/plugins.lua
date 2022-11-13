local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup({
  function(use)
    local lua_path = function(name)
      return string.format([[require'plugins.%s']], name)
    end

    use { 'wbthomason/packer.nvim' }
    -- speeding up
    use { 'lewis6991/impatient.nvim' }
    use { 'nathom/filetype.nvim' }
    --
    use { 'tpope/vim-sensible' }
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-endwise' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'ntpeters/vim-better-whitespace' }
    use {
      'windwp/nvim-autopairs',
      config = function() require('nvim-autopairs').setup {} end
    }
    use {
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup()
        require('plugins.keymappings').run()
      end
    }
    use {
      'TimUntersberger/neogit',
      config = function()
        local neogit = require('neogit')
        neogit.setup()
      end,
      requires = 'nvim-lua/plenary.nvim'
    }
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }
    use { 'AndrewRadev/splitjoin.vim' }
    use { 'wellle/targets.vim' }
    use { 'andymass/vim-matchup' }
    use {
      'notjedi/nvim-rooter.lua',
      config = function()
        require'nvim-rooter'.setup {
          rooter_patterns = { '.git', 'Makefile', 'Cargo.toml', 'package.json', 'Gemfile' }
        }
      end
    }
    use { 'liuchengxu/space-vim-theme' }
    use { 'mg979/vim-visual-multi', branch = 'master' }
    use {
      'akinsho/bufferline.nvim',
      config = function()
        require('bufferline').setup{}
      end,
      tag = 'v3.*',
      requires = 'kyazdani42/nvim-web-devicons',
    }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons'
      },
      config = function()
        require('nvim-tree').setup {
          update_cwd = true,
          update_focused_file = {
            enable = true,
            update_cwd = true
          },
        }
      end
    }
    use {
      'phaazon/hop.nvim',
      config = function()
        require 'hop'.setup()
      end
    }
    use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
      end
    }
    use { 'vim-test/vim-test' }
    use { 'chrisbra/NrrwRgn' }
    use { 'mbbill/undotree' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'windwp/nvim-spectre' }
    use {
      'mfussenegger/nvim-dap',
      config = function()
        require('dapui').setup()
      end
    }
    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local action_layout = require('telescope.actions.layout')
        local trouble = require('trouble.providers.telescope')

        local transform_mod = require('telescope.actions.mt').transform_mod
        local custom_actions = transform_mod {
          file_path = function(prompt_bufnr)
            -- Get selected entry and the file full path
            local content = require('telescope.actions.state').get_selected_entry()
            local full_path = content.cwd .. require('plenary.path').path.sep .. content.value

            -- Yank the path to unnamed register
            vim.fn.setreg('"', full_path)

            -- Close the popup
            require('notify')('File path is yanked')
            actions.close(prompt_bufnr)
          end,
        }

        telescope.setup {
          defaults = {
            sorting_strategy = 'ascending',
            layout_strategy = 'vertical',
            layout_config = {
              vertical = { width = 0.9 }
            },
            mappings = {
              -- restore default behavior
              i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ['<C-t>'] = trouble.open_with_trouble,
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<M-p>'] = action_layout.toggle_preview
              },
              n = {
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<M-p>'] = action_layout.toggle_preview,
                ['<C-t>'] = trouble.open_with_trouble
              }
            },
          },
          pickers = {
            find_files = {
              -- find_command = { 'rg', '--files', '-g' },
              theme = 'ivy',
              mappings = {
                n = {
                  ['y'] = custom_actions.file_path,
                },
                i = {
                  ['<C-y>'] = custom_actions.file_path,
                },
              },
            },
            live_grep = {
              theme = 'ivy',
            },
            grep_string = {
              theme = 'ivy',
            },
            current_buffer_fuzzy_find = {
              theme = 'ivy',
            },
            buffers = {
              theme = 'ivy',
              sort_mru = true
            }
          },
        }
      end,
      requires = { 'nvim-lua/plenary.nvim' }
    }
    use {
      'stevearc/dressing.nvim',
      config = function()
        -- https://github.com/stevearc/dressing.nvim/issues/29
        local dressing = require('dressing')
        dressing.setup({
          input = {
            get_config = function()
              if vim.api.nvim_buf_get_option(0, 'filetype') == 'NvimTree' then
                return { enabled = false }
              end
            end,
            -- mappings = {
            --   n = {
            --     ['C-['] = 'Close',
            --   },
            -- },
          },
          --   select = {
          --     telescope = {
          --       mappings = {
          --         n = {
          --           ['C-['] = 'Close',
          --         },
          --       },
          --     },
          --   },
        })
      end
    }
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup {
          space_char_blankline = " ",
          char_highlight_list = {
            'IndentBlanklineIndent1',
            'IndentBlanklineIndent2',
            'IndentBlanklineIndent3',
            'IndentBlanklineIndent4',
            'IndentBlanklineIndent5',
            'IndentBlanklineIndent6',
          },
        }
      end
    }
    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup()
      end
    }
    use {
      'rcarriga/nvim-notify',
      config = function()
        require('notify').setup({})
      end
    }
    use { 'MunifTanjim/nui.nvim' }
    use {
      'folke/noice.nvim',
      config = function()
        require('noice').setup()
      end,
      requires = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
      }
    }
    use {
      'feline-nvim/feline.nvim',
      after = 'nvim-web-devicons',
      config = lua_path'feline'
      -- config = function()
      --   require('feline').setup({
      --   })
      -- end
    }
    use {
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('trouble').setup {
        }
      end
    }
    require('plugins.treesitter').run(use)
    require('plugins.lsp').run(use)

    if packer_bootstrap then
      require('packer').sync()
    end
  end,

  config = {
    enable = true,
    -- log = { level = 'debug' },
    display = {
      open_fn = require('packer.util').float,
    }
  }
})
