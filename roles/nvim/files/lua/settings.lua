local options = {
  background = 'dark',
  clipboard      = 'unnamed,unnamedplus',   --- Copy-paste between vim and everything else
  cmdheight      = 2,                       --- Give more space for displaying messages
  cindent      = true,
  -- completeopt    = 'menu,menuone,noselect', --- Better autocompletion
  -- cursorline     = true,                    --- Highlight of current line
  -- emoji          = false,                   --- Fix emoji display
  expandtab      = true,                    --- Use spaces instead of tabs
  hlsearch = false,
  -- foldcolumn     = '0',
  -- foldnestmax    = 0,
  -- foldlevel      = 99,                      --- Using ufo provider need a large value
  -- foldlevelstart = 99,                      --- Expand all folds by default
  -- ignorecase     = true,                    --- Needed for smartcase
  -- laststatus     = 3,                       --- Have a global statusline at the bottom instead of one for each window
  list = true,
  lazyredraw = false,                    --- Makes macros faster & prevent errors in complicated mappings
  number     = true, --- Shows current line number
  -- pumheight      = 10,                      --- Max num of items in completion menu
  -- relativenumber = false,                    --- Enables relative number
  -- scrolloff      = 4,                       --- Always keep space when scrolling to bottom/top edge
  shiftwidth     = 2,                       --- Change a number of space characeters inseted for indentation
  -- showtabline    = 2,                       --- Always show tabs
  signcolumn = 'yes:1', --- Add extra sign column next to line number
  -- ignorecase = true,
  -- smartcase  = true, --- Uses case in search
  -- smartindent    = true,                    --- Makes indenting smart
  -- smarttab       = true,                    --- Makes tabbing smarter will realize you have 2 vs 4
  tabstop = 2,                    --- Makes tabbing smarter will realize you have 2 vs 4
  softtabstop = 2,                       --- Insert 2 spaces for a tab
  splitright     = true,                    --- Vertical splits will automatically be to the right
  hidden     = true,
  swapfile       = false,                   --- Swap not needed
  -- tabstop        = 2,                       --- Insert 2 spaces for a tab
  termguicolors  = true,                    --- Correct terminal colors
  timeoutlen = 400,                     --- Faster completion (cannot be lower than 200 because then commenting doesn't work)
  undofile = true, --- Sets undo to file
  undodir = os.getenv('HOME') .. '/.vim/backups',
  updatetime     = 400,                     --- Faster completion
  viminfo        = [['1000]],                 --- Increase the size of file history
  wildignore     = '*node_modules/**',      --- Don't search inside Node.js modules (works for gutentag)
  -- wrap           = true,                   --- Display long lines as just one line
  writebackup = false,                   --- Not needed
  wb = false,
  ttyfast = true,

  -- Neovim defaults
  -- autoindent     = true,                    --- Good auto indent
  -- backspace      = 'indent,eol,start',      --- Making sure backspace works
  backup         = false,                   --- Recommended by coc
  -- conceallevel   = 0,                       --- Show `` in markdown files
  encoding       = 'utf-8',                 --- The encoding displayed
  -- errorbells     = false,                   --- Disables sound effect for errors
  fileencoding   = 'utf-8',                 --- The encoding written to file
  incsearch      = true,                    --- Start searching before pressing enter
  -- showmode       = false,                   --- Don't show things like -- INSERT -- anymore
}

local globals = {
  mapleader = ' ', --- Map leader key to SPC
  better_whitespace_enabled = 1,
  strip_whitespace_on_save = 1,
  strip_whitelines_at_eof = 1,
  strip_whitespace_confirm = 0,
  matchup_surround_enabled = 1,
  matchup_matchparen_deferred = 1,
  matchup_matchparen_deferred_show_delay = 100,
  matchup_matchparen_deferred_hide_delay = 300,
  matchup_matchparen_hi_surround_always = 1,
  -- loaded = 1,
  -- loaded_netrw = 1,
  -- loaded_netrwPlugin = 1,
  -- speeddating_no_mappings     = 1,          --- Disable default mappings for speeddating
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append('c')
vim.opt.matchpairs:append('<:>')
vim.opt.listchars:append 'space:⋅'
vim.opt.listchars:append 'eol:↴'

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

for k, v in pairs(globals) do
  vim.g[k] = v
end

vim.cmd([[
filetype plugin indent on
filetype plugin on
let test#neovim#term_position = "vert"
let g:test#preserve_screen = 1
let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'neovim',
\}
let g:test#neovim#start_normal = 1
" autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
]])

if vim.fn.has('mouse') == 1 then
  vim.opt.mouse = 'a'
end
