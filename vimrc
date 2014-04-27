" vim: set foldmethod=marker sw=2 ts=2:

" very first things:
"   break backwards vi compatibility so vim features work
"   and remove all autocommands
"   and make the vim folder be ~/.vim - windows default is ~/vimfiles
set nocompatible
autocmd!

"=====================Vundle====================="{{{
set rtp=~/.vim,$VIM/vimfiles,$VIMRUNTIME
set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/ycm/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-sensible'
Bundle 'Lokaltog/vim-distinguished'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'Lokaltog/vim-powerline' " using vim-airline now
"Bundle 'jiangmiao/auto-pairs' " possible replacement for delimitMate??
Bundle 'Raimondi/delimitMate'
Bundle 'SirVer/ultisnips'
"Bundle 'Shougo/neocomplete.vim' " using YCM now
"Bundle 'Valloric/YouCompleteMe' " still using YCM, but handling manually because of binaries
"Bundle 'altercation/vim-colors-solarized' " based16 instead
Bundle 'arecarn/crunch'
Bundle 'bling/vim-airline'
Bundle 'chriskempson/base16-vim'
Bundle 'dbarsam/vim-bufkill'
Bundle 'dhruvasagar/vim-vinegar'
Bundle 'docunext/closetag.vim'
"Bundle 'embear/vim-localvimrc' " somethign to look into using in the future
"Bundle 'ervandew/supertab' " use YCM now
"Bundle 'goldfeld/vim-seek' " replaced by vim-sneak
Bundle 'groenewege/vim-less'
Bundle 'itspriddle/vim-jquery'
Bundle 'ivan-cukic/vim-ctrlp-switcher'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'justinmk/vim-gtfo'
Bundle 'justinmk/vim-sneak'
Bundle 'kana/vim-altr'
Bundle 'kien/ctrlp.vim'
Bundle 'kshenoy/vim-signature'
"Bundle 'maciakl/vim-neatstatus' " using vim-airline now
"Bundle 'majutsushi/tagbar'
"Bundle 'marijnh/tern_for_vim' " tern just to slow, us jscomplete-vim for now
Bundle 'mattn/emmet-vim'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'michaeljsmith/vim-indent-object'
"Bundle 'mileszs/ack.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'https://bitbucket.org/teramako/jscomplete-vim.git'
Bundle 'terryma/vim-expand-region'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
"Bundle 'vim-scripts/YankRing.vim' " using vim-yankstack now
Bundle 'vim-scripts/ZoomWin'
Bundle 'vim-scripts/dbext.vim'
Bundle 'vim-scripts/matchit.zip'
"}}}

"=====================General Options====================="{{{
filetype plugin indent on
" enable syntax coloring
syntax enable

" force unix file format
set fileformat=unix
set fileformats=unix,dos
"set nobinary

" look for dictionary files specific to filetypes
"au FileType * exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))

" for arduino files
"autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" sets up backup/undo/swap dirs
let s:dir = has('win32') ? '$HOME\.vim\' : '~/.vim/'
if isdirectory(expand(s:dir))
  if &directory =~# '^\.,'
    let &directory = expand(s:dir) . '/swap//,' . &directory
  endif
  if &backupdir =~# '^\.,'
    let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
  endif
  if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
    let &undodir = expand(s:dir) . '/undo//,' . &undodir
  endif
endif
if exists('+undofile')
  set undofile
endif

" some options to set up text complete - mostly just the defaults
" see: http://robots.thoughtbot.com/post/27041742805/vim-you-complete-me
set wildmode=longest,list:longest
set completeopt=menu

" these options automatically save fold state and cursor state when closing and
" leaving a buffer, so new open the folds and cursor are in the same position
set viewoptions="folds,options,cursor"
"au BufWinLeave * silent! mkview
"au BufWinEnter * silent! loadview

" these options list what is saved when using mksession (and vim-sensible)
set sessionoptions=blank,buffers,curdir,folds,help,options,resize,tabpages,winpos,winsize

" enable syntax highlighting for jquery javascript
"au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
au BufRead,BufNewFile .jshintrc set ft=javascript

" Set number of spaces for tabs
if has("win32")
  "use 4 spaces at work
  set shiftwidth=4
  set tabstop=4
else
  set shiftwidth=2
  set tabstop=2
endif
set expandtab

" set maximum text width to 80 character
" will automatically break after 80 chars
" and formatting will also shorten lines
set textwidth=80
set wrapmargin=80
set wrap
set sidescroll=1

" let h and l keys go to next line when they hit the end/beginning of line
set whichwrap=b,s,h,l

" set the search scan to wrap lines
set wrapscan

" set the search scan so that it ignores case when the search is all lower
" case but recognizes uppercase if it's specified
set ignorecase
set smartcase

" set the forward slash to be the slash of note.  Backslashes suck
"set shellslash " BUT THIS BREAKS SYNTASTIC

" disable all error bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" make the command line one line high
" change to get a taller command line
set cmdheight=1

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" when using 'cw' and like commands, put a $ at the end instead of just
" deleting it
set cpoptions+=$

" Set the status line the way i like it
"set statusline=%f\ %y\ %m\ %r\ %h\ %w\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\
" this adds rvm info to status line"
"set statusline+=Ruby:
"set statusline+=%{rvm#statusline()}
" these new three lines show syntax errors in the status line using syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" Use C style smart indenting
" apparently breaks some plugins
"set cindent

" Keep backup files around (files that end in ~)
" and put backup files in ~/.vim/backups/
" and .swp files in ~/.vim/swp/
set backup
set writebackup

" turn on line numbering
set nu

" don't show the current mode
set noshowmode

" hide mouse pointer while typing
set mousehide

" enable mouse usage in terminal vim, good for moving splits
"set mouse=a

" supposed to fix tmux mouse usage
set ttymouse=xterm2

" faster rendering in console
set ttyfast

" grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" get rid of silly characters in seperators
set fillchars=""

" set tags so that it searches in the current directory for the tags file
set tags=tags

" set spellcheck options
set spelllang=en

" settings to make windows keep nice heights and widths
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=10
set winminheight=10
set winheight=999

" when switching to a different buffer, if it's open in another window go to
" that window, otherwise open it in the current window
"set switchbuf=useopen

" the 'j' option will remove leading comment characters when joining line
set formatoptions+=j
"}}}
"
"=====================JavaScript mapping====================="{{{
augroup javascript
  autocmd!
  autocmd FileType javascript :setlocal omnifunc=jscomplete#CompleteJS
  "autocmd FileType javascript nnoremap <buffer> <C-]> :TernDef<CR>
  "autocmd FileType javascript nnoremap <buffer> <C-T> <C-O>
augroup END
"}}}
"
"=====================Java mapping====================="{{{
augroup java
  autocmd!
  autocmd FileType java nnoremap <buffer> <C-]> :JavaSearchContext<CR>
  autocmd FileType java nnoremap <buffer> <F3> :JavaSearchContext<cr>
  autocmd FileType java nnoremap <buffer> <C-T> <C-O>
  autocmd FileType java nnoremap <buffer> <leader>i :JavaImport<cr>
  autocmd FileType java nnoremap <buffer> <c-s-f> :%JavaFormat<cr>
  autocmd FileType java nnoremap <buffer> <leader>C :JavaCorrect<cr>
augroup END
"}}}

"=====================Windows options====================="{{{
if has("win32")
  " if in windows it means I'm at work, so these settings are for work code

  "set shell=powershell.exe
  "set shellcmdflag=/c\ powershell.exe\ -NoLogo\ -NoProfile\ -NonInteractive\ -ExecutionPolicy\ RemoteSigned
  "set shellpipe=|
  "set shellredir=>
  "let $TMP="C:/tmp"
  set wak=no " attempt to fix using ALT in mapping
  set textwidth=120
  set wrapmargin=120
endif
"}}}

"=====================GUI options====================="{{{
if has("gui_running")
  " get rid of the toolbar
  set guioptions-=T
  " get rid of right hand scroll bar
  set guioptions-=r
  " get rid of left scrollbar
  set guioptions-=L
  " get rid of menu
  set guioptions-=m

  " set the font to something nice
  if has("win32")
    set guifont=Inconsolata:h12
  else
    set guifont=Inconsolata\ Medium\ 12
  endif
endif

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" highlight the line the cursor is on
set cursorline
"}}}

"=====================Folding options====================="{{{
" Use markers to decide where to fold
set foldmethod=indent
" Add a 2 character column to give visual indication of folds
set foldcolumn=2
" make all folds open by default using a high setting shere
set foldlevel=20

" these mappings will open and close folds or create new folds using spacebar
nnoremap <silent> <leader><leader> @=(foldlevel('.')?'za':'l')<CR>
"vnoremap <Space> zf
"}}}

"=====================Color Related Things====================="{{{
"colorscheme mayansmoke "a nice light scheme
if has("gui_running")
  set background=dark
  "colorscheme solarized
  colorscheme base16-bright
  "colorscheme distinguished
else
  set background=dark
  "let base16colorspace=256  " Access colors present in 256 colorspace
  "colorscheme base16-tomorrow
  colorscheme distinguished
endif

"}}}

"=====================Functions====================="{{{
" pretty print json using python
function! DoPrettyJSON()
python << endpython
import vim, json

buf = vim.current.buffer
js = json.loads("".join(buf))
pretty = json.dumps(js, indent=2, separators=(',',': ')).split("\n")
buf[:] = None # delete buffer contents
buf.append(pretty)
del buf[0] # append adds to the second line, so delete first blank line
endpython
endfunction
command! PrettyJSON call DoPrettyJSON()

function! DoPrettyXML()
python << endpython
import vim
from bs4 import BeautifulSoup

buf = vim.current.buffer
xml = BeautifulSoup("".join(buf))
pretty = xml.prettify("ascii").split("\n")
del buf[:] # delete buffer contents
buf.append(pretty)
del buf[0] # append adds to the second line, so delete first blank line
endpython
endfunction
command! PrettyXML call DoPrettyXML()

" HARD MODE, can only move using searches!
function! HardModeOn()
  nmap h :echo "HARD MODE"<cr>
  nmap l :echo "HARD MODE"<cr>
  nmap j :echo "HARD MODE"<cr>
  nmap k :echo "HARD MODE"<cr>
endfunction
function! HardModeOff()
  unmap h
  unmap l
  unmap j
  unmap k
  nmap j gj
  nmap k gk
endfunction

"turn logging on, log goes to ~/.vim/log
function! ToggleVerbose()
  if !&verbose
    set verbosefile=~/.vim/log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
endfunction

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let cmd = 'Start! sed -i "./' . f . '/d" "' . tagfilename . '"'
  exe cmd
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let f = substitute(f, cwd . "/", "", "")
  let tagfilename = "./tags"
  let cmd = 'Start! ctags -a -f "' . tagfilename . '" "./' . f . '"'
  call DelTagOfFile(f)
  exe cmd
endfunction
"autocmd BufWritePost *.java,*.js,*.xsl call UpdateTags()

" visually select text then use '~' to change case
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ ygv"=TwiddleCase(@")<CR>Pgv

" preserve state, helper function
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Following four functions are for running tests
function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  if match(a:filename, '\.feature$') != -1
    exec ":!script/features " . a:filename
  else
    if filereadable("script/test")
      exec ":!script/test " . a:filename
    elseif filereadable("Gemfile")
      exec ":!bundle exec rspec --color " . a:filename
    else
      exec ":!rspec --color " . a:filename
    end
  end
endfunction

function! SetTestFile()
  " Set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number . " -b")
endfunction

function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction

" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<c-p>"
    endif
endfunction

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction
"}}}

"=====================Key Mappings====================="{{{
" make <C-c> act like <ESC>
vmap <C-c> <ESC>
imap <C-c> <ESC>

" always typing :W when I mean :w"
command! W :w

" save with ctrl-s
nmap <c-s> :w<cr>

" change the <leader> character to ','
let mapleader = ','

" Edit and source the vimrc file
nnoremap <silent> <leader>ev :exec ":e " . g:vimrc<CR>
nnoremap <silent> <leader>sv :exec ":so " . g:vimrc<CR>

" switch windows with alt-arrow keys
nmap <silent> <c-s-c> :wincmd c<CR>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" map arrow keys to nothing so I don't use them anymore! learn the hard way
noremap <Left>  <nop>
noremap <Right> <nop>
noremap <Up>    <nop>
noremap <Down>  <nop>
inoremap <Left>  <nop>
inoremap <Right> <nop>
inoremap <Up>    <nop>
inoremap <Down>  <nop>

" change j and k so that when the line is really long and it wraps they will
" work as expected
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" beginning and end of line
noremap <silent> <c-h> ^
noremap ^ :echo "use <c-h>!"<cr>
noremap <silent> <c-l> $
noremap $ :echo "use <c-l>!"<cr>

" switch to last used buffer
nnoremap <silent> <space><space> <c-^>

" Increase and decrease window width
:nmap <A-.> :vertical res +2<cr>
:nmap <A-,> :vertical res -2<cr>

" This toggles the highlighting of searches - hit return in normal mode
nnoremap <CR> :set hlsearch!<CR>
" but still want return to run the command in the command window
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
autocmd FileType qf nnoremap <buffer> <CR> <CR>

" using tags, when over a word type alt-] to open the tag in a virtical split
nnoremap <silent> <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" using tags, when there is more than one matching tag, use ,n to go to next tag
" and close the current window
nmap <leader>n :BD<cr> :tnext<cr>

" map ,ss to spellcheck
nnoremap <silent> <leader>ss :set spell!<CR>

" change directory to that of current file
nnoremap <silent> <leader>cd :cd%:p:h<cr>

" change directory to that of current file - but just for current window
"nnoremap <silent> <leader>lcd :lcd%:p:h<cr>

" clean up a file: (in this order)
" -remove \r (^M) characters
" -remove trailing white space
" -turn tabs into spaces
nnoremap <silent> <leader>rs :silent! :call Preserve("%s/\r//g\|%s/\\s\\+$//e\|:retab")<CR>

" fix tab formatting of buffer
nnoremap <silent> <c-s-f> :silent! :call Preserve("normal gg=G")<CR>

" fix formatting of paragraph block: line length and tabs
nnoremap <silent> <leader>FP :silent! :call Preserve("normal vipgq")<CR>

" toggle comment status of selected lines using NERDCommenter
noremap <silent> <leader>cc ,c<space>

" mapping to copy from clipboard xclip program needed
"nnoremap <silent> <leader>v :r ! xclip -o<CR>

" mapping to paste to the system clipboard
nnoremap <silent> <leader>v "*p
vnoremap <silent> <leader>c "*y

" run a test.sh script in the current directory
nnoremap <silent> <A-T> :!./test.sh<CR>

" open rails 'special' files in top window
" nnoremap <silent> <leader>gr :topleft :split config/routes.rb<cr>
" nnoremap <silent> <leader>gR :call ShowRoutes()<cr>
" nnoremap <silent> <leader>gg :topleft 100 :split Gemfile<cr>

" find directory of current file
"cnoremap <silent> %% <C-R>=expand('%:h').'/'<cr> "old way
cabbr %% <C-R>=expand('%:p:h') . '/'<CR>

" edit or view files in directory of current file
"nnoremap <silent> <leader>e :edit %% "old way
nnoremap <leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" switching forward and backward between buffers
" <C-Tab> doesn't work via ssh or command line
"nnoremap <silent> <C-Tab> :bn<cr>
"nnoremap <silent> <S-Tab> :bp<cr>
nnoremap <silent> <leader><Tab> :bn<cr>
nnoremap <silent> <leader><S-Tab> :bp<cr>

" running tests
" Run this file
nnoremap <silent> <leader>t :call RunTestFile()<cr>
" Run only the example under the cursor
nnoremap <silent> <leader>T :call RunNearestTest()<cr>
" Run all test files
nnoremap <silent> <leader>A :call RunTests('')<cr>

" smart tab completion
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <s-tab> <c-n>

" Insert a hash rocket with <c-l>
inoremap <c-l> <space>=><space>

" toggle display of quickfix, and location list
nnoremap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>

nmap ]] ]m
nmap [[ [m

nnoremap <leader>L kA {<esc>jo}<esc>k==

nmap # :set relativenumber!<cr>

" find version control conflict markers
nnoremap <silent> ]C /\v^[<>=]{4}($\|\s)<CR>
nnoremap <silent> [C ?\v^[<>=]{4}($\|\s)<CR>

" fix bug with yankstack, it overwrites sneak's mappings
call yankstack#setup()
nmap s <Plug>SneakForward
nmap S <Plug>SneakBackward

"replace 'f' with inclusive 1-char Sneak
"nmap f <Plug>Sneak_f
"nmap F <Plug>Sneak_F
"xmap f <Plug>Sneak_f
"xmap F <Plug>Sneak_F
"omap f <Plug>Sneak_f
"omap F <Plug>Sneak_F
"replace 't' with exclusive 1-char Sneak
"nmap t <Plug>Sneak_t
"nmap T <Plug>Sneak_T
"xmap t <Plug>Sneak_t
"xmap T <Plug>Sneak_T
"omap t <Plug>Sneak_t
"omap T <Plug>Sneak_T

vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
"}}}

"=====================General Autocommands====================="{{{
augroup vimrcEx
 " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "autocmd VimEnter * unmap! <Tab>

  " set a nice title for the vim window
  autocmd BufEnter * let &titlestring = "VIM | " . expand("%:t") . " |"

  autocmd FileType qf wincmd J " Open QuickFix horizontally
augroup END
"}}}

"=====================CtrlP settings====================="{{{
" Open files with ,f
let g:ctrlp_extensions = ["funky","switcher"]
let g:ctrlp_map = "<leader>f"
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_depth = 100
let g:ctrlp_max_files = 100000
let g:ctrlp_switch_buffer = ""
let g:ctrlp_clear_cache_on_exit = 0

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v(\.git|\.svn|etc|build|node_modules|bower_components|eclipse-build|test-output)$',
  \ 'file': '\v\.(exe|so|dll|jar|class)$',
  \ }

let g:ctrlpswitcher_project_sources="server"

nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>m :CtrlPMRU<cr>
"nmap <leader>s :CtrlPSwitch<cr>
nmap <leader>a :let @z=substitute(expand("%:t:r"), "\\..*$", "", "")<CR>:CtrlP<CR><C-\>rz

nmap <leader>u :CtrlPFunky<cr>
nmap <leader>gw :CtrlP<cr><C-\>w
nmap <leader>gf vi""zy:CtrlP<cr><C-\>rz
vmap <leader>gv "zy:CtrlP<cr><C-\>rz
"nmap <leader>gc :CtrlP app/collections<cr>
"nmap <leader>gm :CtrlP app/models<cr>
"nmap <leader>gr :CtrlP app/routers<cr>
"nmap <leader>gv :CtrlP app/views<cr>
"nmap <leader>gt :CtrlP test/spec<cr>
"}}}

"=====================NerdTree settings====================="{{{
let g:NERDTreeShowBookmarks=1
" can't seem to get this next setting to work properly
"let g:NERDTreeBookmarksFile='$HOME/.vim/NERDTreeBookmarks'

nmap <leader>do :NERDTreeToggle<CR>
nmap <leader>df :NERDTreeFind<CR>
nmap <leader>dc :NERDTreeCWD<CR>
"}}}

"=====================TagBar settings====================="{{{
" toggle taglist window
"nnoremap <silent> <leader>o :TagbarToggle<CR>

"let g:tagbar_type_xslt = {
      "\ 'ctagstype' : 'xslt',
      "\ 'kinds'     : [
      "\ 'n:templates (named)',
      "\ 'm:templates (matched)',
      "\ 'a:applied templates',
      "\ 'c:called templates',
      "\ 'f:functions',
      "\ 'p:parameters',
      "\ 'v:variables'
      "\ ]
      "\ }
"}}}

"=====================SuperTab settings====================="{{{
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabMappingForward = "<c-space>"
"let g:SuperTabMappingBackward = "<s-c-space>"
"let g:SuperTabClosePreviewOnPopupClose = 1
"}}}

"=====================Syntastic settings====================="{{{
" turn on the little arrow that shows errors
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_conf = '.jshintrc'
"let g:syntastic_debug=3

" open/update errors window created by syntastic
nnoremap <C-S-e> :Errors<CR>
"}}}

"=====================SnipMate settings====================="{{{
"let g:snips_author = "Robert McBride"
"let g:snips_trigger_key = "<tab>"
"let g:snipMate = {}
"let g:snipMate.scope_aliases = {}
"let g:snipMate.scope_aliases['jsp'] = 'jsp,html'
"}}}

"=====================Ultisnip settings====================="{{{
let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsSnippetsDir = "~/.vim/snips/"
let g:UltiSnipsSnippetDirectories=["snips","UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsDontReverseSearchPath="1"

map <leader>ue :UltiSnipsEdit<cr>
"}}}

"=====================ZenCoding settings====================="{{{
let g:user_zen_leader_key = '<c-y>'
"}}}

"=====================Eclim settings====================="{{{
"turn off some validation, slows the editor down a lot
let g:EclimCssValidate = 0
let g:EclimHtmlValidate = 0
let g:EclimXmlValidate = 0
let g:EclimJavascriptValidate = 0
let g:EclimCompletionMethod = "omnifunc"
let g:EclimBrowser = "chrome"
let g:EclimJavaSearchSingleResult = "edit"
" not working??
"nmap <silent> <c-x> :call eclim#vimplugin#FeedKeys('Ctrl+Alt+x')<cr>
"nmap <silent> <c-m> :call eclim#vimplugin#FeedKeys('Ctrl+M')<cr>
"}}}

"=====================DBEXT settings====================="{{{
"let g:dbext_default_window_use_horiz = 0 "open split on right instead of bottom
let g:dbext_default_profile_robm1 = "type=MYSQL:user=medaccess:passwd=madb:dbname=robm1:host=devdb02.ma.net:port=3301"
let g:dbext_default_profile_robm2 = "type=MYSQL:user=medaccess:passwd=madb:dbname=robm2:host=devdb02.ma.net:port=3301"
let g:dbext_default_profile_robm3 = "type=MYSQL:user=medaccess:passwd=madb:dbname=robm3:host=devdb02.ma.net:port=3301"
let g:dbext_default_profile_robm4 = "type=MYSQL:user=medaccess:passwd=madb:dbname=rm_calmmc:host=devdb02.ma.net:port=3301"
"let g:dbext_default_profile = "rob1"
let g:dbext_default_prompt_for_parameters = 0 "turn off the 'feature' where it prompts you for parameters
"}}}

"=====================DelimitMate settings====================="{{{
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"}}}

"=====================BufKill settings====================="{{{
let g:BufKillCreateMappings = 0 " don't create ,.. mapping
let g:BufKillActionWhenModifiedFileToBeKilled = 'confirm' " if file contents have changed, ask if you want to save it
"}}}

"=====================Altr settings====================="{{{
call altr#remove_all()
call altr#define('src/ui/*/%.js', 'src/ui/*/%.spec.js')
call altr#define('src/ui/*/*/%.js','src/ui/*/*/%.spec.js')
call altr#define('src/ui/*/*/*/%.js','src/ui/*/*/*/%.spec.js')
call altr#define('client/js/%.js','client/spec/%.spec.js')
nmap <F2> <Plug>(altr-forward)
"}}}

"=====================easymotion settings====================="{{{
let g:EasyMotion_leader_key = '<space>'
"}}}

"=====================airline settings====================="{{{
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_b='' " remove (hunks, branch)
let g:airline_section_y='' " remove (fileencoding, fileformat)
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
"}}}

"=====================tern settings====================="{{{
"let g:tern_show_argument_hints = 'on_hold'
"}}}
