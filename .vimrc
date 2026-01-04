" Global Settings
set nocompatible       " We don't want vi compatibility.
set ttyfast
set lazyredraw
set showcmd            " Show (partial) command in status line.
set noshowmatch        " Show matching brackets.
set mouse=a            " Enable mouse usage (all modes) in terminals
set mousehide          " Hide mouse after chars typed
set encoding=utf-8     " you really should be using utf-8 now
set termencoding=utf-8 " ditto
set clipboard^=unnamed
set clipboard^=unnamedplus " Yanks go on clipboard instead.
set history=10000      " Number of things to remember in history.
set timeoutlen=250     " Time to wait after ESC (default causes an annoying delay)
set laststatus=2       " Always show status line.
set directory=~/.vim/
set tildeop            " Enable using tilde to swap case
set ruler              " Ruler on
set nu                 " Line numbers on
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l/%L,%c\ %)%P

" Search
set incsearch  " show 'best match so far' as you type
set nohls      " Don't highlight matches. Use :set hls when needed.
set ignorecase " ignores case of letters on searches
set smartcase  " Override 'ignorecase' if the search pattern has upper case

" Tabs and Indentation
set expandtab
set smarttab
set smartindent   " smart indent of code - indent after opening '{',
set autoindent    " Copy indent from current line when starting a new line
set shiftwidth=4  " Number of spaces to use for each step of (auto)indent
set tabstop=4     " Number of spaces that a <Tab> in the file counts for.
set softtabstop=4 " Backspace the proper number of spaces
set shiftround    " Round indent to multiple of 'shiftwidth'

" Wrapping
set wrap
set sidescroll=5
"set listchars+=precedes:<,extends:>

" Scroll
set scrolloff=8 " Scrolling keeps 8 lines at top/bottom

" Filetype and Synatx Highlighting
filetype on          " Automatically detect file types
filetype indent on   " Filetype specific indentation
filetype plugin on
set fileencodings=   " don't do any encoding conversion (otherwise munges binary files)
syntax on            " Syntax Highlighting
" colorscheme selection is below

" Completion
set wildmode=longest,full
set wildignore+=*.o,*~,.lo " ignore object files
set wildmenu               " menu has tab completion

" Folds
"noremap <space> za   " Toggle folding
set foldlevel=100     " Default all folds open
set foldmethod=manual " Set foldmethod
nnoremap <F5> zfa}
