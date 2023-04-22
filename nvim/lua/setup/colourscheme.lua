---- Set colorscheme options before hand or the colours won't work correctly
--
vim.g.everforest_background = "hard"
vim.g.everforest_disable_italic_comment = 1
vim.g.everforest_sign_column_background = "none"
vim.g.everforest_diagnostic_text_highlight = 1
vim.g.gruvbox_contrast_light = "medium"

---- Set the overall theme colour. default is dark
--
-- o.background = "light"


---- Themes that don't respect the background option
--
-- colorscheme nightfox
-- vim.cmd "colorscheme dayfox"
-- vim.cmd "colorscheme dawnfox"
-- colorscheme duskfox
-- colorscheme nordfox
vim.cmd "colorscheme carbonfox"

---- Dark and Light themes
-- -----------------------

-- colorscheme everforest
-- colorscheme gruvbox

---- Dark-only themes
-- ----------------------


-- After theme has been set alter the split colour so it's easier
-- to see where panes windows start/end
vim.api.nvim_set_hl(0, "WinSeparator", { ctermbg = "none" })
