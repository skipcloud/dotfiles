local bo = vim.bo
local current_buf = 0

bo.expandtab = false
bo.softtabstop = 0
bo.shiftwidth = 0
-- Still use tabs but make them four chars wide
bo.tabstop = 4

-- GoExtractFunc is a range user command that calls the refactor
-- code action, basically to extract code to a method or function
vim.api.nvim_buf_create_user_command(current_buf, "GoExtractFunc",
	function()
		vim.lsp.buf.code_action({
			context = {
				only = { 'refactor.extract' }
			},
			range = {
				-- send the most recent visual selection
				start = vim.api.nvim_buf_get_mark(0, "<"),
				['end'] = vim.api.nvim_buf_get_mark(0, ">")
			}
		})
	end,
	{
		range = true
	}
)
