local M = {}

function M.run()
  local wk = require('which-key')
  local leader_nnoremap_opts = {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil,
    silent = false,
    noremap = true,
    nowait = false,
  }

  local nnoremap_opts = {
    mode = 'n',
    prefix = '',
    buffer = nil,
    silent = false,
    noremap = true,
    nowait = false,
  }

  local leader_n_opts = {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil,
    silent = false,
    noremap = false,
    nowait = false,
  }

  local n_opts = {
    mode = 'n',
    prefix = '',
    buffer = nil,
    silent = false,
    noremap = false,
    nowait = false,
  }

  local c_opts = {
    mode = 'c',
    prefix = '',
    buffer = nil,
    silent = false,
    noremap = false,
    nowait = false,
  }

  local i_opts = {
    mode = 'i',
    prefix = '',
    buffer = nil,
    silent = false,
    noremap = false,
    nowait = false,
  }

  local n_opts_silent = {
    mode = 'n',
    prefix = '',
    buffer = nil,
    silent = true,
    noremap = false,
    nowait = false,
  }

  local leader_nnoremap_opts_silent = {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  }

  local leader_n_opts_silent = {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil,
    silent = true,
    noremap = false,
    nowait = false,
  }

  local x_opts = {
    mode = 'x',
    prefix = '',
    buffer = nil,
    silent = false,
    noremap = false,
    nowait = false,
  }

  local t_opts = {
    mode = 't',
    prefix = '',
    buffer = nil,
    silent = false,
    noremap = false,
    nowait = false,
  }

  local leader_vnoremap_opts = {
    mode = 'v',
    prefix = '<leader>',
    buffer = nil,
    silent = false,
    noremap = true,
    nowait = false,
  }

  local expr_i_opts = {
    mode = 'i',
    prefix = '',
    buffer = nil,
    silent = false,
    noremap = false,
    nowait = false,
    expr = true,
    replace_keycodes = true,
  }

  local expr_c_opts = {
    mode = 'c',
    prefix = '',
    buffer = nil,
    silent = false,
    noremap = false,
    nowait = false,
    expr = true,
    replace_keycodes = true,
  }

  wk.register({
    b = {
      name = 'buffer',
      d = { ':bd!<CR>', 'delete buffer' },
      e = { ':e<cr>', 'eval buffer' },
      f = { ':bf<CR>', 'first buffer' },
      l = { ':bl<CR>', 'last buffer' },
      n = { ':bn<CR>', 'next buffer' },
      p = { ':bp<CR>', 'previous buffer' },
      s = { '<cmd>Telescope buffers<cr>', 'buffers list' },
      x = { ':%bd|e#|bd#<CR>', 'delete all but current buffer' },
    },
    f = {
      name = 'file',
      e = {
        name = 'config',
        d = { ':e $MYVIMRC<cr>', 'open conf' },
        R = { ':so $MYVIMRC<cr>', 'reload conf' },
      },
      f = { '<cmd>Telescope find_files<cr>', 'find file' },
      s = { '<cmd>StripWhitespace<cr><cmd>w!<cr>', 'save file' },
    },
    q = {
      q = { ':q!<cr>', 'quit' },
    },
    w = {
      name = 'window',
      c = { ':on<cr>', 'close other windows' },
      d = { '<C-w>c', 'delete current window' },
    },
    ['*'] = { '<cmd>Telescope grep_string<cr>', '' },
  }, leader_n_opts)

  wk.register({
    u = { ':UndotreeToggle<cr>', 'undo tree' },
  }, leader_nnoremap_opts_silent)

  wk.register({
    d = { '<cmd>NvimTreeToggle<cr>', 'toggle tree' },
    g = { [[<cmd>lua require('neogit').open({ kind = 'split' })<cr>]], 'open git' },
    r = {
      w = { [[<cmd>lua require('spectre').open_visual({select_word=true})<cr>]], '' },
    },
    q = {
      f = { '<cmd>TroubleToggle quickfix<cr>', 'trouble quickfix' },
      t = { '<cmd>TroubleToggle<cr>', 'toggle trouble' },
    },
    ['<C-b>'] = { '<cmd>Gitsigns toggle_current_line_blame<cr>', 'toggle git blame' },
  }, leader_nnoremap_opts)

  wk.register({
    r = {
      t = {
        f = { '<cmd>TestFile<cr>' , 'run test file' },
        n = { '<cmd>TestNearest<cr>', 'run nearest test' },
        -- f = { [[<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>]] , 'run test file' },
        -- n = { [[<cmd>lua require('neotest').run.run()<cr>]], 'run nearest test' },
      },
    },
  }, leader_n_opts_silent)

  wk.register({
    r = {
      w = { [[<cmd>lua require('spectre').open_visual()<cr>]], '' },
    },
  }, leader_vnoremap_opts)

  wk.register({
    g = {
      C = { ':HopChar1<cr>', 'go to char' },
      w = { ':HopWord<cr>', 'go to word' },
      d = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'go to definition' },
    },
    ['*'] = { '<cmd>Telescope live_grep<cr>', 'grep live' },
    ['/'] = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'grep current buffer' },
    ['[e'] = { 'ddp', 'move line down' },
    [']e'] = { 'ddkP', 'move line up' },
    ['<C-l>'] = { '<C-w>l', 'right window' },
    ['<C-h>'] = { '<C-w>h', 'left window' },
    ['<C-j>'] = { '<C-w>j', 'lower window' },
    ['<C-k>'] = { '<C-w>k', 'upper window' },
    ['<C-g>'] = { '<C-[>', 'emacs cancel' },
  }, n_opts)

  wk.register({
    ['<C-[>'] = { '<C-\\><C-n>', '' },
  }, t_opts)

  wk.register({
    ['//'] = { ':nohlsearch<cr>', '' },
  }, n_opts_silent)

  wk.register({
  --   ['[e'] = { 'dp', '' },
  --   [']e'] = { 'dkP', '' },
  }, x_opts)

  wk.register({
    ['<C-g>'] = { '<C-[>', 'emacs cancel' },
  }, i_opts)

  wk.register({
    ['<C-g>'] = { '<C-[>', 'emacs cancel' },
  }, c_opts)

  local minibuffer = {}

  function minibuffer.next()
    return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-j>'
  end

  function minibuffer.prev()
    return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-k>'
  end

  _G.my.minibuffer = minibuffer

  wk.register({
    -- works either way
    ['<C-j>'] = { 'v:lua.my.minibuffer.next()', 'minibuffer down' },
    ['<C-k>'] = { 'v:lua.my.minibuffer.prev()', 'minibuffer up' },
    -- ['<C-j>'] = { [[pumvisible() ? '<C-n>' : '<C-j>']], 'minibuffer down' },
    -- ['<C-k>'] = { [[pumvisible() ? '<C-p>' : '<C-k>']], 'minibuffer up' },
  }, expr_i_opts)

  wk.register({
    -- works either way
    ['<C-j>'] = { 'v:lua.my.minibuffer.next()', 'minibuffer down' },
    ['<C-k>'] = { 'v:lua.my.minibuffer.prev()', 'minibuffer up' },
    -- ['<C-j>'] = { [[pumvisible() ? '<C-n>' : '<C-j>']], 'minibuffer down' },
    -- ['<C-k>'] = { [[pumvisible() ? '<C-p>' : '<C-k>']], 'minibuffer up' },
  }, expr_c_opts)
end

return M
