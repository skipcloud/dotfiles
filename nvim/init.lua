
-- Download vim-plug if it isn't installed
fn = vim.fn
if fn.empty(fn.glob(fn.stdpath("data") .. '/site/autoload/plug.vim')) == 1 
then
				vim.cmd([[
					silent execute '!curl -fLo '..stdpath("data")..'/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
					:PlugInstall --sync | source $MYVIMRC
				]])
end

require "setup.options"
require "setup.plugins"
require "setup.colourscheme"
require "setup.mappings"
require "setup.autocmds"
