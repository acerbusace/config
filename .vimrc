"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> Setup Vundle -> Load Plugins
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files, backups and undo
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs, windows and buffers
"    -> Status line
"    -> Editing mappings
"    -> Misc
"    -> Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Setup Vundle -> Load Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" skip initialization for vim-tiny or vim-small
if 0 | endif

if &compatible
  set nocompatible " be iMproved, required for vundle
endif
filetype off " required for vundle

let bundle = expand('~/.vim/bundle/')
if has('win32') || has('win64')
  let bundle = expand('~/vimfiles/bundle/')
endif

let vundleInstalled = 0
let vundle = expand(bundle . 'Vundle.vim/')
let readme = expand(vundle . 'README.md')

" auto install vundle, if not found
if !filereadable(readme)
  silent !git --version
  if v:shell_error == 0
    let gitVundle = 'https://github.com/VundleVim/Vundle.vim.git'
    silent execute '!git clone ' . gitVundle . ' ' . vundle

    " opens up cmd vim to ':PluginInstall', if no errors occured while
    " installing vundle
    if v:shell_error == 0
      let vundleInstalled = 1
      silent !vim +PluginInstall +qall
    endif
  endif
else
  let vundleInstalled = 1
endif

if vundleInstalled == 1
  " set the runtime path to include Vundle and initialize
  let &rtp = &rtp . ',' . vundle
  " set rtp+=~/vimfiles/bundle/Vundle.vim/

  call vundle#begin(bundle)

  " let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'

  Plugin 'scrooloose/nerdtree'
  Plugin 'ctrlpvim/ctrlp.vim'
  Plugin 'tpope/vim-commentary'

  " Plugin 'tpope/vim-fugitive' " git plugin

  Plugin 'vim-airline/vim-airline'

  " All of your Plugins must be added before the following line

  call vundle#end()            " required
endif

" Enable filetype plugins
filetype plugin indent on " required for vundle

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" detect when a file is changed
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has('win32') || has ('win64')
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" always show current position
set ruler

" enables the number line
set nu 

" height of the command bar
set cmdheight=2

" toggle between normal and relative numbering.
nnoremap <leader>r :call NumberToggle()<cr>

" a buffer becomes hidden when it is abandoned
set hid

" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" ignore case when searching
set ignorecase

" when searching try to be smart about cases 
set smartcase

" highlight search results
set hlsearch

" makes search act like search in modern browsers
set incsearch 

" disable search highlighting until next search bye pressing <esc>
nnoremap <esc> :noh<return><esc>

" don't redraw while executing macros (good performance config)
set lazyredraw 

" for regular expressions turn magic on
set magic

" show matching brackets when text indicator is over them
set showmatch 
" how many tenths of a second to blink when matching brackets
set mat=2

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" add a bit extra margin to the left
" set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable " Enable syntax highlighting

try
  colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=m " remove menu bar
    set guioptions-=T " remove tool bar
    set guioptions-=r " remove right-hand scroll bar
    set guioptions-=L " remove left-hand scroll bar
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t

    " toggles the menu bar
    nnoremap <C-F2> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Set GUI font
if has('win32') || has('win64')
  set gfn=Consolas:h11:cANSI:qDRAFT    
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use spaces instead of tabs
set expandtab

" 1 tab == 2 spaces
set shiftwidth=2 " number of columns text is indented with the reindent operation (<< and >>)
set tabstop=2 " number of columns a tab counts for
set softtabstop=2 " number of columns when the tab key is pressed

set ai " auto indent
set si " smart indent
set wrap " wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" visual mode pressing * or # searches for the current selection
" vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
" vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" causes nerd tree split opening problem
" horizontal split below current
" set splitbelow
" vertical split to right of current
" set splitright

" smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" close the current buffer
" map <leader>bd :Bclose<cr>:tabclose<cr>gT

" close all the buffers
" map <leader>ba :bufdo bd<cr>

" map <leader>l :bnext<cr>
" map <leader>h :bprevious<cr>

" useful mappings for managing tabs
" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove 
" map <leader>t<leader> :tabnext 

" specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" always show the status line
set laststatus=2

" enables airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
" defines 'straight' tabs
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" enables the use of powerline fonts
" let g:airline_powerline_fonts = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" move a line of text using ALT+[jk] or Command+[jk] on mac
" nmap <M-j> mz:m+<cr>`z
" nmap <M-k> mz:m-2<cr>`z
" vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
" vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" if has("mac") || has("macunix")
  " nmap <D-j> <M-j>
  " nmap <D-k> <M-k>
  " vmap <D-j> <M-j>
  " vmap <D-k> <M-k>
" endif

" delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove the Windows ^M - when the encodings gets messed up
" noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" quickly open a markdown buffer for scribble
" map <leader>x :e ~/buffer.md<cr>

" toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configure Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
" map <leader>nb :NERDTreeFromBookmark
" map <leader>nf :NERDTreeFind<cr>


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <c-f> :CtrlP<cr>
" map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
