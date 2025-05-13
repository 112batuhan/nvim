vim.keymap.set("n", "my", "<cmd>wa<CR>", { desc = "Shorthand for :w" })
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Window focus keys with arrow keys

vim.keymap.set("n", "<C-w><Left>", "<C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-w><Down>", "<C-w>j", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-w><Up>", "<C-w>k", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-w><Right>", "<C-w>l", { desc = "Move focus to the right window" })

-- Emulate <C-w><Arrow> behavior
vim.keymap.set("n", "<C-w><Left>", "<C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-w><Down>", "<C-w>j", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-w><Up>", "<C-w>k", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-w><Right>", "<C-w>l", { desc = "Move focus to the right window" })

-- Scroll keymaps
vim.keymap.set("n", "<S-Up>", "<C-U>", { desc = "Scroll up with cursor" })
vim.keymap.set("n", "<S-Down>", "<C-D>", { desc = "Scroll down with cursor" })
vim.keymap.set("n", "<C-Up>", "10<C-Y>", { desc = "Scroll up" })
vim.keymap.set("n", "<C-Down>", "10<C-E>", { desc = "Scroll down" })

-- Line keymaps (i'm not using "sentence" keybindings so it's fine)
vim.keymap.set("n", ")", "$", { noremap = true, silent = true, desc = "go to the start of the line ($)" })
vim.keymap.set("n", "(", "^", { noremap = true, silent = true, desc = "go to the end of the line (^)" })
vim.keymap.set("x", ")", "$", { noremap = true, silent = true, desc = "go to the start of the line ($)" })
vim.keymap.set("x", "(", "^", { noremap = true, silent = true, desc = "go to the end of the line (^)" })
vim.keymap.set("o", ")", "$", { noremap = true, silent = true, desc = "go to the start of the line ($)" })
vim.keymap.set("o", "(", "^", { noremap = true, silent = true, desc = "go to the end of the line (^)" })

vim.keymap.set("n", "gp", "<C-^> ", { desc = "Go to previous file" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
