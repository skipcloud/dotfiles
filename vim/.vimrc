set nocompatible " be iMproved, required
filetype off     " required for Vundle, re-enabled later

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf

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

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
colorscheme tender
" colorscheme delek
" colorscheme spacecamp_lite

set path+=** " Set path to search recursively
set wildmenu " display all matching files when tab complete
set number   " line numbers
highlight LineNr ctermfg=white 
" set relativenumber
set showcmd  "show incomplete cmds down the bottom
set showmode "show current mode down the bottom

set autoindent	" always set autoindenting on

set backspace=start,eol,indent " allow backspace to delete auto indent, newlines

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set incsearch
set hlsearch " Switch on highlighting the last used search pattern.
set ignorecase
set smartcase
set mouse=a
set splitright " vertical split to the right
set linebreak " wrap on whitespace

set tabstop=8 softtabstop=2 expandtab shiftwidth=2 smarttab
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
" remove scratch pad from autocomplete
set completeopt-=preview

set writebackup " protect against crash-during-write 		
set nobackup    " but do not persist backup after successful write
set backupcopy=auto " use rename-and-write-new method whenever safe
set backupdir=$HOME/.vim/.backup//

" set swapfile
set directory^=$HOME/.vim/.swap//

set undofile	" keep an undo file (undo changes after closing)
set undodir^=$HOME/.vim/.undo//
set autowrite " save when calling make/next/etc

" fix mouse not working past 220th column and resizing splits
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" Go related
set autowrite " save when calling make/next/etc
let g:go_fmt_command = "goimports"
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
" set list lcs=tab:\|\ 

" Status bar
set laststatus=2
set statusline=
" file name
set statusline+=%.40F 
" modified
set statusline+=%2*%m%*
" buffer number
set statusline+=\ \-\ Buffer:\ %n

set statusline+=%=
" column
set statusline+=\ %c
" line number
set statusline+=\ \-\ %l 
" total lines
set statusline+=\ \-\ %L 
" percentage through file
set statusline+=\ \-\ %p%%

" Status bar colour
highlight statusline ctermfg=white

" Removing escape
ino jj <esc>
cno jj <c-c>
vno v <esc>

" ins-completion CTRL-X mappings
:inoremap ^] ^X^]
:inoremap ^F ^X^F
:inoremap ^D ^X^D
:inoremap ^L ^X^L

" My leader key
let mapleader=","
noremap \ ,

" Remove highlights with leader + enter
nmap <Leader><CR> :nohlsearch<cr>

map <leader>q :NERDTreeToggle<CR>

" Activate fuzzy search
map <C-p> :FZF<cr>

" move between tabs
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" trim all whitespace
nnoremap <Leader>w :call TrimWhiteSpace()<cr>

fun! TrimWhiteSpace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

" Save session
noremap <Leader>s :call SaveSession()<cr>

fun! SaveSession()
  execute 'mksession! ~/.vim/sessions/default.vim'
endfun

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  augroup vimStartup
    au!
    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " tab settings for Makefiles
    autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd BufWritePre *.rb,*.tf,*.proto,*.go :call TrimWhiteSpace() 
    " ^N causes included files to be read which slows down
    " autocomplete a hell of a lot
    autocmd BufNewFile,BufRead *spec.rb setlocal complete-=i

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END
endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
