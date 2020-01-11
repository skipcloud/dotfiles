" vim:foldmethod=marker
set nocompatible " be iMproved, required

" set the runtime path to include Vundle and FZF
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Plugins {{{1
filetype off     " required for Vundle, re-enabled later
call vundle#begin()
" colourschemes
Plugin 'jaredgorski/spacecamp'
Plugin 'jacoborus/tender.vim'

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'jparise/vim-graphql'
Plugin 'vim-ruby/vim-ruby'
" snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" split/join
Plugin 'AndrewRadev/splitjoin.vim'

" Optional:
Plugin 'honza/vim-snippets'

" Autogenerate pair ({[
Plugin 'jiangmiao/auto-pairs'

" Navigation tree
Plugin 'scrooloose/nerdtree'

" change surrounding brackets/quotes/parens etc
Plugin 'tpope/vim-surround'
" handy [ and ] mappings
Plugin 'tpope/vim-unimpaired'
" make vim-commentary and vim-surround work with .
Plugin 'tpope/vim-repeat'
" Commenting and uncommenting stuff
Plugin 'tpope/vim-commentary'
" Git wrapper
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'

Plugin 'tpope/vim-rails'
" Fuzzy search
Plugin 'junegunn/fzf'

" Testing
Plugin 'keith/rspec.vim'
Plugin 'janko-m/vim-test'

" indent markers
Plugin 'Yggdroot/indentLine'

Plugin 'fatih/vim-go'
Plugin 'mdempsky/gocode', {'rtp': 'vim/'}
Plugin 'SirVer/ultisnips' " Go snippets

" replace grep
Plugin 'jremmen/vim-ripgrep'

" markdown folding
Plugin 'masukomi/vim-markdown-folding'

Plugin 'godlygeek/tabular'

Plugin 'hashivim/vim-terraform'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Options/Customisations {{{1
" Appearance{{{2
syntax on
colorscheme tender
" colorscheme delek
" colorscheme spacecamp_lite
highlight Visual ctermfg=yellow ctermbg=blue " set visual selection colours that stand out
highlight VertSplit ctermfg=white

set number   " line numbers
" set relativenumber
set showcmd   " show incomplete cmds down the bottom
set showmode  " show current mode down the bottom
set wildmenu  " display all matching files when tab complete
set ruler     " show the cursor position all the time
set incsearch " incremental search
set hlsearch  " Switch on highlighting the last used search pattern.


if has("mouse_sgr") " fix mouse not working past 220th column and resizing splits
    set ttymouse=sgr
else
    set ttymouse=xterm2
end
" Status bar {{{3
set laststatus=2
set statusline=
set statusline+=%.40F             " file name
set statusline+=%2*%m%*           " modified
set statusline+=\ \-\ Buffer:\ %n " buffer number
set statusline+=%=                " buffer number
set statusline+=\ col\ %c         " column
set statusline+=\ \-\ line\ %l    " line number
" set statusline+=\ \-\ %L           " total lines
set statusline+=\ \-\ %p%%         " percentage through file
" Status bar colour
highlight statusline ctermfg=white 
highlight LineNr ctermfg=white 

" Behaviour {{{2
" General {{{3
set tabstop=8 softtabstop=2 expandtab shiftwidth=2 smarttab " default tab behaviour
set path+=**                   " Set path to search recursively
set autoindent                 " always set autoindenting on
set backspace=start,eol,indent " allow backspace to delete auto indent, newlines
set history=200                " keep 200 lines of command line history
set splitright                 " vertical split to the right
set linebreak                  " wrap on whitespace
set clipboard=unnamedplus      " Ensure clipboard works on linux
set ignorecase                 " ignore case in search patterns
set smartcase                  " override ignorecase if searching with capital letters
set completeopt-=preview       " remove scratch pad from autocomplete
set complete+=kspell           " check dictionary when autocompete is used and spell is enabled
set mouse=a                    " this is 'a' by default but for some reason needs set explicitly on my linux machine
set dictionary=/usr/share/dict/words
set spelllang=en

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case " ripgrep settings

" Backups/Swap/Undo/Other Directories {{{3
set writebackup                    " protect against crash-during-write
set nobackup                       " but do not persist backup after successful write
set backupcopy=auto                " use rename-and-write-new method whenever safe
set backupdir=$HOME/.vim/.backup//
set swapfile                       " swap file enabled
set directory^=/tmp//              " put them in the tmp directory
set undofile                       " keep an undo file (undo changes after closing)
set undodir^=$HOME/.vim/.undo//
set autowrite                      " save when calling make/next/etc
set tags^=./.git/tags;             " tags file for Fugative

" Plugin options {{{1
" Go related
let g:go_fmt_command = "goimports"
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
" let g:go_auto_type_info = 1 " show type info in status bar

" Mappings {{{1

let mapleader="," " My leader key
noremap \ ,
" easily get back normal mode
ino jj <esc> 
" ins-completion CTRL-X mappings
inoremap ^] ^X^]
inoremap ^F ^X^F
inoremap ^D ^X^D
inoremap ^L ^X^L
map <C-p> :FZF<cr>
nmap <Leader><CR> :nohlsearch<cr>
map <leader>q :NERDTreeToggle<CR>
nnoremap <Leader>w :call TrimWhiteSpace()<cr>

" Functions {{{1
fun! TrimWhiteSpace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

" Autocmds {{{1
" Only do this part when compiled with support for autocommands.
if has("autocmd")
  augroup vimStartup
    au!
    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    autocmd FileType gitcommit setlocal spell

    " tab settings for Makefiles
    autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

    autocmd BufWritePre *.rb,*.tf,*.proto,*.go,*.c :call TrimWhiteSpace()
    " ^N causes included files to be read which slows down
    " autocomplete a hell of a lot
    autocmd BufNewFile,BufRead *spec.rb setlocal complete-=i

    autocmd BufNewFile,Bufread *.md setlocal spell textwidth=80

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

    " Go related
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd FileType go nmap <Leader>i <Plug>(go-info)

    autocmd BufWritePost .vimrc source $MYVIMRC

    autocmd BufNewFile,BufRead .gitconfig setlocal noexpandtab tabstop=8 shiftwidth=8

    " Autofold markdown files
    autocmd FileType markdown set foldexpr=NestedMarkdownFolds()

    augroup END
endif " has("autocmd")

