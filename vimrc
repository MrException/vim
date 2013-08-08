" vim: set foldmethod=marker sw=2 ts=2:

" very first things:
"   break backwards vi compatibility so vim features work
"   and remove all autocommands
"   and make the vim folder be ~/.vim - windows default is ~/vimfiles
set nocompatible
autocmd!

"=====================Vundle====================="{{{
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-sensible'

Bundle 'Lokaltog/vim-easymotion'
"Bundle 'Lokaltog/vim-powerline'
Bundle 'Raimondi/delimitMate'
Bundle 'SirVer/ultisnips'
Bundle 'altercation/vim-colors-solarized'
Bundle 'dbarsam/vim-bufkill'
Bundle 'docunext/closetag.vim'
Bundle 'ervandew/supertab'
Bundle 'goldfeld/vim-seek'
Bundle 'groenewege/vim-less'
Bundle 'itspriddle/vim-jquery'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'kana/vim-altr'
Bundle 'kien/ctrlp.vim'
Bundle 'kshenoy/vim-signature'
Bundle 'maciakl/vim-neatstatus'
Bundle 'majutsushi/tagbar'
"Bundle 'marijnh/tern_for_vim'
Bundle 'mattn/zencoding-vim'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'mileszs/ack.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'terryma/vim-expand-region'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
"Bundle 'vim-scripts/YankRing.vim'
Bundle 'vim-scripts/ZoomWin'
Bundle 'vim-scripts/dbext.vim'
Bundle 'vim-scripts/matchit.zip'
"}}}

"=====================General Options====================="{{{
" enable syntax coloring
syntax enable

" force unix file format
set fileformat=unix
"set nobinary

" look for dictionary files specific to filetypes
"au FileType * exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))

" for arduino files
"autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" sets up backup/undo/swap dirs
let s:dir = has('win32') ? '$APPDATA/Vim' : match(system('uname'), "Darwin") > -1 ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
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

" show the current mode
set showmode

" hide mouse pointer while typing
set mousehide

" enable mouse usage in terminal vim, good for moving splits
set mouse=a

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
set switchbuf=useopen
"}}}

"=====================Windows options====================="{{{
if has("win32")
  "set shell=powershell.exe
  "set shellcmdflag=/c\ powershell.exe\ -NoLogo\ -NoProfile\ -NonInteractive\ -ExecutionPolicy\ RemoteSigned
  "set shellpipe=|
  "set shellredir=>
  let $TMP="C:/tmp"
  set wak=no " attempt to fix using ALT in mapping
endif
"}}}

"=====================GUI options====================="{{{
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
set foldmethod=manual
" Add a 2 character column to give visual indication of folds
set foldcolumn=2
" make all folds open by default using a high setting shere
set foldlevel=20

" these mappings will open and close folds or create new folds using spacebar
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf
"}}}

"=====================Color Related Things====================="{{{
"colorscheme mayansmoke "a nice light scheme
if has("gui_running")
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

"}}}

"=====================Functions====================="{{{
" toggle between relative and normal line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunction

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

function! DoWrapLineInNewBlock()
python << endpython
import vim

buf = vim.current.buffer
win = vim.current.window
(row,col) = win.cursor
buf.append("{",row-1);
buf.append("}",row+1);
vim.eval("feedkeys('=3j','n')")
endpython
endfunction
command! WrapLineInNewBlock call DoWrapLineInNewBlock()

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
autocmd BufWritePost *.java,*.js,*.xsl call UpdateTags()

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
noremap <silent> <C-c> <ESC>

" always typing :W when I mean :w"
command! W :w

" save with ctrl-s
nmap <c-s> :w<cr>

" change the <Leader> character to ','
let mapleader = ','

" Edit and source the vimrc file
nnoremap <silent> <Leader>ev :exec ":e " . g:vimrc<CR>
nnoremap <silent> <Leader>sv :exec ":so " . g:vimrc<CR>

" map arrow keys to nothing so I don't use them anymore! learn the hard way
noremap <Left>  :echo "no!"<cr>
noremap <Right> :echo "no!"<cr>
noremap <Up>    :echo "no!"<cr>
noremap <Down>  :echo "no!"<cr>
"nmap <Left>  h
"nmap <Right> l
"nmap <Up>    k
"nmap <Down>  j

" change j and k so that when the line is really long and it wraps they will
" work as expected
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" map J and K to go 10 lines up or down
nnoremap <silent> <C-j> 10j
nnoremap <silent> <C-k> 10k

" beginning and end of line
noremap <silent> <C-h> ^
noremap <silent> <C-l> $

" switch to last used buffer
nnoremap <silent> <space><space> <c-^>

" Easy window navigation
" Don't really use these anymore
"nmap <A-h> <C-w>h
"nmap <A-j> <C-w>j
"nmap <A-k> <C-w>k
"nmap <A-l> <C-w>l
"nmap <A-c> <C-w>c

" Increase and decrease window width
:nmap <A-.> :vertical res +2<cr>
:nmap <A-,> :vertical res -2<cr>

" when a omni-complete popup is visible use C-j and C-k to go up and down
" default map is C-p and C-n which is ok, leaving these here as examples
":inoremap <C-j> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-j>"<CR>
":inoremap <C-k> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-k>"<CR>

"This toggles the highlighting of searches - hit return in normal mode
nnoremap <silent> <CR> :set hlsearch!<CR>

" using tags, when over a word type alt-] to open the tag in a virtical split
nnoremap <silent> <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" using tags, when there is more than one matching tag, use ,n to go to next tag
" and close the current window
nmap <Leader>n :BD<cr> :tnext<cr>

" map ,ss to spellcheck
nnoremap <silent> <Leader>ss :set spell!<CR>

" change directory to that of current file
nnoremap <silent> <Leader>cd :cd%:p:h<cr>

" change directory to that of current file - but just for current window
nnoremap <silent> <Leader>lcd :lcd%:p:h<cr>

" clean up a file: (in this order)
" -remove \r (^M) characters
" -remove trailing white space
" -turn tabs into spaces
nnoremap <silent> <Leader>rs :silent! :call Preserve("%s/\r//g\|%s/\\s\\+$//e\|:retab")<CR>

" fix tab formatting of buffer
nnoremap <silent> <Leader>FF :silent! :call Preserve("normal gg=G")<CR>

" fix formatting of paragraph block: line length and tabs
nnoremap <silent> <Leader>FP :silent! :call Preserve("normal vipgq")<CR>

" toggle comment status of selected lines using NERDCommenter
noremap <silent> <Leader>cc ,c<space>

" mapping to copy from clipboard xclip program needed
"nnoremap <silent> <Leader>v :r ! xclip -o<CR>

" mapping to paste to the system clipboard
nnoremap <silent> <Leader>v "*p
vnoremap <silent> <Leader>c "*y
nnoremap <silent> <Leader>c<CR> "*yy

" run a test.sh script in the current directory
nnoremap <silent> <A-T> :!./test.sh<CR>

" open rails 'special' files in top window
" nnoremap <silent> <Leader>gr :topleft :split config/routes.rb<cr>
" nnoremap <silent> <Leader>gR :call ShowRoutes()<cr>
" nnoremap <silent> <Leader>gg :topleft 100 :split Gemfile<cr>

" find directory of current file
"cnoremap <silent> %% <C-R>=expand('%:h').'/'<cr> "old way
cabbr %% <C-R>=expand('%:p:h') . '/'<CR>

" edit or view files in directory of current file
"nnoremap <silent> <Leader>e :edit %% "old way
nnoremap <Leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" switching forward and backward between buffers
nnoremap <silent> <Leader><Tab> :bn<cr>
nnoremap <silent> <Leader><S-Tab> :bp<cr>

" running tests
" Run this file
nnoremap <silent> <Leader>t :call RunTestFile()<cr>
" Run only the example under the cursor
nnoremap <silent> <Leader>T :call RunNearestTest()<cr>
" Run all test files
nnoremap <silent> <Leader>A :call RunTests('')<cr>

" smart tab completion
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <s-tab> <c-n>

" close the current buffer, and close the current window
"nnoremap <silent> <Leader>bd :BD<cr>\|<C-w>c

" Insert a hash rocket with <c-l>
inoremap <c-l> <space>=><space>

nnoremap <silent> <buffer> <F3> :JavaSearchContext<cr>
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>

" toggle display of quickfix, and location list
nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>
nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>

nmap ]] ]m
nmap [[ [m

nmap <leader>L :call DoWrapLineInNewBlock()<CR>

imap <c-n> <c-x><c-n>

"nmap <leader>fl :Utl<CR>

"nmap <leader>bl :Bufferlist<CR>

nmap <leader># :call NumberToggle()<cr>
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
augroup END

"autocmd FocusLost * :set number
"autocmd FocusGained * :set relativenumber
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber
"}}}

"=====================CtrlP settings====================="{{{
" Open files with ,f
let g:ctrlp_map = "<leader>f"
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_depth = 100
let g:ctrlp_max_files = 100000
"let g:ctrlp_custom_ignore = '.*class$\|.*sql$\|.*jar$\|.*svn.*\|.*build.*\|etc.*'

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v(\.git|\.svn|etc|build|node_modules|eclipse-build)$',
  \ 'file': '\v\.(exe|so|dll|jar|class)$',
  \ }

nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>m :CtrlPMRU<cr>
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

nmap <Leader>d :NERDTreeToggle<CR>
"}}}

"=====================TagBar settings====================="{{{
" toggle taglist window
nnoremap <silent> <Leader>o :TagbarToggle<CR>

let g:tagbar_type_xslt = {
      \ 'ctagstype' : 'xslt',
      \ 'kinds'     : [
      \ 'n:templates (named)',
      \ 'm:templates (matched)',
      \ 'a:applied templates',
      \ 'c:called templates',
      \ 'f:functions',
      \ 'p:parameters',
      \ 'v:variables'
      \ ]
      \ }
"}}}

"=====================SuperTab settings====================="{{{
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabMappingForward = "<c-space>"
let g:SuperTabMappingBackward = "<s-c-space>"
let g:SuperTabClosePreviewOnPopupClose = 1
"}}}

"=====================Syntastic settings====================="{{{
" turn on the little arrow that shows errors
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_conf = '.jshintrc'

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
let g:UltiSnipsSnippetsDir = "~/.vim/snippets/"
let g:UltiSnipsSnippetDirectories=["snippets","UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
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

let g:EclimBrowser = "chromium"
" not working??
"nmap <silent> <c-x> :call eclim#vimplugin#FeedKeys('Ctrl+Alt+x')<cr>
"nmap <silent> <c-m> :call eclim#vimplugin#FeedKeys('Ctrl+M')<cr>
"}}}

"=====================DBEXT settings====================="{{{
let g:dbext_default_window_use_horiz = 0 "open split on right instead of bottom
let g:dbext_default_profile_robm1 = "type=MYSQL:user=medaccess:passwd=madb:dbname=robm1:host=devdb02.ma.net:port=3301"
let g:dbext_default_profile_robm2 = "type=MYSQL:user=medaccess:passwd=madb:dbname=robm2:host=devdb02.ma.net:port=3301"
let g:dbext_default_profile_robm3 = "type=MYSQL:user=medaccess:passwd=madb:dbname=robm3:host=devdb02.ma.net:port=3301"
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
call altr#define('src/ui/*/%.js', 'MedAccess/web/WEB-INF/ui-test/unit/*/%.spec.js')
nmap <F2> <Plug>(altr-forward)
"}}}

"=====================easymotion settings====================="{{{
"let g:EasyMotion_leader_key = '<Leader>'
"}}}
