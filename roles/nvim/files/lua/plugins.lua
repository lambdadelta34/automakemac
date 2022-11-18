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
    -- use { "alexghergh/nvim-tmux-navigation" }
    use { 'tpope/vim-sensible' }
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-endwise' }
    use {
      'folke/tokyonight.nvim',
      config = function()
        require('tokyonight').setup {
          style = 'moon',
          light_style = 'moon',
          styles = {
            comments = { italic = false },
            keywords = { italic = false },
            functions = { italic = false },
            variables = { italic = false },
            sidebars = "dark",
            floats = "dark",
          },
        }
        vim.cmd([[
        colorscheme tokyonight
        highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine
        highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine
        highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
        highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine
        highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
        highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine
        ]])
      end
    }
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
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
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
        local lib = require("nvim-tree.lib")
        local view = require("nvim-tree.view")


        local function collapse_all()
          require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
        end

        local function edit_or_open()
          -- open as vsplit on current node
          local action = "edit"
          local node = lib.get_node_at_cursor()

          -- Just copy what's done normally with vsplit
          if node.link_to and not node.nodes then
            require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
            view.close() -- Close the tree if file was opened

          elseif node.nodes ~= nil then
            lib.expand_or_collapse(node)

          else
            require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
            view.close() -- Close the tree if file was opened
          end

        end

        local function vsplit_preview()
          -- open as vsplit on current node
          local action = "vsplit"
          local node = lib.get_node_at_cursor()

          -- Just copy what's done normally with vsplit
          if node.link_to and not node.nodes then
            require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

          elseif node.nodes ~= nil then
            lib.expand_or_collapse(node)

          else
            require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

          end

          -- Finally refocus on tree if it was lost
          view.focus()
        end

        require('nvim-tree').setup {
          view = {
            mappings = {
              custom_only = false,
              list = {
                { key = "l", action = "edit", action_cb = edit_or_open },
                { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
                { key = "h", action = "close_node" },
              }
            },
          },
          actions = {
            open_file = {
              quit_on_open = false
            }
          },
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
        local sorters = require('telescope.sorters')
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
        telescope.load_extension('fzf')
        telescope.setup {
          extensions = {
            fzf = {
              fuzzy = true,                    -- false will only do exact matching
              override_generic_sorter = true,  -- override the generic sorter
              override_file_sorter = true,     -- override the file sorter
              case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            }
          },
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
              fuzzy = false,
              case_mode='ignore_case',
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
        require('noice').setup {
        }
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
          use_diagnostic_signs = true,
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
