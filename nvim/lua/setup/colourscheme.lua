local set = vim.api.nvim_set_var 
local hightlight = vim.api.nvim_set_hl

---- Set colorscheme options before hand or the colours won't work correctly
--
set("everforest_background", "hard")
set("everforest_disable_italic_comment", 1)
set("everforest_sign_column_background", "none")
set("everforest_diagnostic_text_highlight", 1)
set("gruvbox_contrast_light", "medium")

---- Set the overall theme colour. default is dark
--
-- o.background = "light"


---- Themes that don't respect the background option
-- 
-- colorscheme nightfox
vim.cmd "colorscheme dayfox"
-- colorscheme dawnfox
-- colorscheme duskfox
-- colorscheme nordfox
-- colorscheme terafox

---- Dark and Light themes 
-- -----------------------

-- colorscheme everforest
-- colorscheme gruvbox

---- Dark-only themes
-- ----------------------


-- After theme has been set alter the split colour so it's easier
-- to see where panes windows start/end
vim.api.nvim_set_hl(0, "WinSeparator", {ctermbg="none"})
