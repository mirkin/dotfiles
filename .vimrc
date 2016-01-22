" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
        execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
"source .vimrc if changed
augroup reload_vimrc " {
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
" plugins, :PlugInstall in vim commentd mode to install
call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
"syntax checker
Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlpctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
Plug 'nathanaelkane/vim-indent-guides'
"auto closing quotes parens etc.
Plug 'Raimondi/delimitMate'
call plug#end()
set number "show line numbers
set tw=79 " width used by gd
set nowrap " don't wrap on load
set fo-=t " dont's wrap while typing
set colorcolumn=80 "dont want over 79 so show the width
highlight ColorColumn ctermbg=233 " color of ColorColumn overwritten by ColorScheme though
"on mac
set rtp+=$HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim/
"on linux
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set t_Co=256
set title
set showmode
filetype indent on
" Set to auto read when a file is changed from the outside
set autoread
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" powerline fonts for airline plugin
let g:airline_powerline_fonts=1
" at least 2 buffers before top bar is used
let g:airline#extensions#tabline#buffer_min_count = 2
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "badwolf"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Coding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" visual spaces per tab
set tabstop=4
" spaces per tab while editing
set softtabstop=4
" use spaces for tabs
set expandtab
" reindent << >>
set shiftwidth=4
" save view and reload handy to restore folding
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview
"folding
set foldmethod=syntax
"js reformat
noremap <leader>fj :%!js-beautify -f - -w 80 --type js
"html reformat
noremap <leader>fh :%!js-beautify -f - --type html
" enable delimit mate plugin to expand spaces and cr
let delimitMate_expand_space=1
let delimitMate_expand_cr=1
" ctags for <ctrl-]> etc where to find the tags file
"tags=./tags,tags
"tags+=tags;$HOME search tags recursively from current folder to home dir ~
set tags+=tags;$HOME
noremap <leader>ct :!ctags -R
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

vnoremap < <gv " keeps selection when indent and outdent
vnoremap > >gv
map <Enter> o<ESC>
"toggle relative number mode
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber
		else
		set relativenumber
	endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Handling 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"disable backup and swap files - they rigger events for file system watchers
set nobackup
set nowritebackup
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

"show whitespace must be inserted before colorcheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

colorscheme badwolf
set background=dark


" Set extra options when running in GUI mode
if has( "gui_running")
	set guioptions-=T
	set guioptions+=e
	set t_Co=256
	set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

au FileType py set smartindent
set modeline
" autocomplete closing ) and put cursor back inside
":inoremap ( ()<Esc>i 
set runtimepath^=~/.vim/bundle/ctrlp.vim,~/.vim/bundle/nerdtree
" Give a shortcut key to NERD Tree
map <F2> :NERDTreeToggle<CR>
"Show hidden files in NerdTree
let NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	en
	return ''
endfunction
