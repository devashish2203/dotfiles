set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" All of your Plugins must be added before the following line
call vundle#end()            " required


let g:airline_powerline_fonts = 1
let g:airline_theme='kolor'
let g:airline#extensions#tabline#enabled = 1

" Global Settings
set nocompatible       " We don't want vi compatibility.
set ttyfast
set lazyredraw
set showcmd            " Show (partial) command in status line.
set noshowmatch        " Show matching brackets.
set encoding=utf-8     " you really should be using utf-8 now
set termencoding=utf-8 " ditto
set clipboard^=unnamed
"set clipboard^=unnamedplus " Yanks go on clipboard instead.
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

" Font
set guifont=mononoki\ 10,Monaco\ 11,Monospace\ 11
set guifont=mononoki\ 10,Monaco\ 11,DejaVu\ Sans\ Mono\ 11,Monospace\ 11


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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous Tweaks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Y yanks till the end of the line
:map Y y$

" Dictionary for keyword i_C-X_C-K completion
set dictionary=/usr/share/dict/words


" visual shifting (builtin-repeat)
:vnoremap < <gv
:vnoremap > >gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits
:set winminheight=0
map <C-W><C-Left> <C-W>h
map <C-W><C-Right> <C-W>l

" Zoom current window
"map <C-z> <C-W>_
" Resize window
map <C-z> <C-W><
map <C-x> <C-W>>
map <C-b> <C-W>+
map <C-n> <C-W>-

" Tabs
":map <C-t> :tabnew<CR>
":map <C-q> :tabclose<cr>
":map <C-p> :tabprevious<cr>
":map <C-n> :tabnext<cr>
"noremap <silent> <C-Left> :exe "silent! tabmove " . (tabpagenr() - 2)<CR>
"noremap <silent> <C-Right> :exe "silent! tabmove " . tabpagenr()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype Specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Comments are not placed in the first column.
" They stay at their current indent level
inoremap # #

" Python formatting
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Highlight the methodnames in C++
function! EnhanceCppSyntax()
  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  hi def link cppFuncDef Special
endfunction
autocmd Syntax cpp call EnhanceCppSyntax()

autocmd FileType python nnoremap <buffer> [[ ?^class\\|^\s*def<CR>
autocmd FileType python nnoremap <buffer> ]] /^class\\|^\s*def<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set listchars=tab:➝\ ,space:·,trail:·
set listchars=tab:»\ ,nbsp:\ ,trail:»

set list

"unmap <cr>
imap <C-Right> <esc>ea
imap <C-Left> <esc>bi


autocmd FileType  c,cpp,h,hpp,cxx   setlocal cc=81 | setlocal shiftwidth=2 | setlocal tabstop=2 | setlocal softtabstop=2 | set noic
autocmd FileType  python            setlocal cc=81
autocmd FileType  xml,json          setlocal foldmethod=indent | setlocal cc=81 | setlocal shiftwidth=2 | setlocal tabstop=2 | setlocal softtabstop=2 | set noic

function! Vimdiff()
    let lines = getline(0, '$')
    let la = []
    let lb = []
    for line in lines
        if line[0] == '-'
            call add(la, line[1:])
        elseif line[0] == '+'
            call add(lb, line[1:])
        else
            call add(la, line)
            call add(lb, line)
        endif
    endfor
    "tabnew
    botright split
    set bt=nofile
    vertical new
    set bt=nofile
    call append(0, la)
    diffthis
    exe "normal \<C-W>l"
    call append(0, lb)
    diffthis
endfunction
autocmd FileType diff nnoremap <silent> <leader>vd :call Vimdiff()<CR>

