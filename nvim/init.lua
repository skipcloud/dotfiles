-- Download vim-plug if it isn't installed
local fn = vim.fn
if fn.empty(fn.glob(fn.stdpath("data") .. '/site/autoload/plug.vim')) == 1 then
  vim.cmd([[
		silent execute '!curl -fLo '..stdpath("data")..'/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		:PlugInstall --sync | source $MYVIMRC
	]])
end

local modules = {
  "setup.options",
  "setup.plugins",
  "setup.colourscheme",
  "setup.mappings",
  "setup.lsps",
  "setup.autocmds",
}

-- This loop allows me to source this file and reload
-- nvim config without restarting
for _, m in ipairs(modules) do
  package.loaded[m] = nil
  require(m)
end
