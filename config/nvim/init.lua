vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#606060' })
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '│ ' }
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.keymap.set('n', 'w', ':w<CR>', { noremap = true })
vim.keymap.set('n', 'q', ':q<CR>', { noremap = true })
