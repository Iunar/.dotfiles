
vim.keymap.set('n', '<leader>a', function()
	require('harpoon.mark').add_file()
end)

vim.keymap.set('n', '<leader>p', function()
	require('harpoon.ui').toggle_quick_menu()
end)

vim.keymap.set('n', '<leader>j', function()
	require('harpoon.ui').nav_next()
end)

vim.keymap.set('n', '<leader>k', function()
	require('harpoon.ui').nav_prev()
end)
