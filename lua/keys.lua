-- telescope keybinds
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })

-- file ex keybinds
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- random binds
vim.keymap.set('n', '<C-s>', ':w', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>tt', ':Term', { noremap = true, silent = true })
