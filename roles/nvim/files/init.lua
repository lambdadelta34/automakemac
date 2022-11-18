pcall(require, 'impatient')

_G.my = {}

require('plugins')
require('functions')
require('settings')

-- reload nvim on neogit crashes
-- neo tree topmost folder doesnt cd back on CR
-- git commit is crashing
-- git commit is not worjing nice with noice
