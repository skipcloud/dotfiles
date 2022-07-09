M = {}

-- TrimWhiteSpace trims the whitespace from the ends of lines
function M.TrimWhiteSpace()
				save = vim.fn.winsaveview()
				vim.cmd([[%s/\s\+$//e]])
				vim.fn.winrestview(save)
end

return M
