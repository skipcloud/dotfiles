M = {}

-- TrimWhiteSpace trims the whitespace from the ends of lines
function M.TrimWhiteSpace()
	local save = vim.fn.winsaveview()
	vim.cmd([[%s/\s\+$//e]])
	vim.fn.winrestview(save)
end

-- Bet you can't work out what this one does
function M.ReloadConfig()
	dofile(vim.env.MYVIMRC)
	print("Config reloaded")
end

return M
