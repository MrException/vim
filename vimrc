"=====================General Options====================="{{{
" break backwards vi compatibility so vim features work
set nocompatible

" Use plugins
" Need to first disable filetype then turn on
" pathogen, only after pathogen is working do
" we re-enable filetype stuff
"filetype off
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
call pathogen#infect()
syntax on
filetype plugin indent on

" look for dictionary files specific to filetypes
"au FileType * exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))

" for arduino files
"autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" and set this so the dictionary file will be used
"set complete+=k

" these options automatically save fold state and cursor state when closing and
" leaving a buffer, so new open the folds and cursor are in the same position
"set viewoptions="folds,cursor"
"au BufWinLeave * silent! mkview
"au BufWinEnter * silent! loadview

" enable syntax highlighting for jquery javascript
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

" Use four characters for tabs and expand tabs to spaces
set shiftwidth=2
set tabstop=2
set expandtab

" backspace over these things works
set backspace=eol,indent,start

" set maximum text width to 80 character
" will automatically break after 80 chars
" and formatting will also shorten lines
set textwidth=80
set wrapmargin=80

" keep lots of command history
set history=1000

" let h and l keys go to next line when they hit the end/beginning of line
set whichwrap=b,s,h,l

" set the search scan to wrap lines
set wrapscan

" make search start highlighting as you type the search pattern
set incsearch

" set the search scan so that it ignores case when the search is all lower
" case but recognizes uppercase if it's specified
set ignorecase
set smartcase

" set the forward slash to be the slash of note.  Backslashes suck
set shellslash

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
set statusline=%f\ %y\ %m\ %r\ %h\ %w\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\
" this adds rvm info to status line"
"set statusline+=Ruby:
"set statusline+=%{rvm#statusline()}
" these new three lines show syntax errors in the status line using syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" always show status line
set laststatus=2

" Use C style smart indenting
" apparently breaks some plugins
"set cindent

" Keep backup files around (files that end in ~)
" and put backup files in ~/.vim/backups/
" and .swp files in ~/.vim/swp/
set backup
set writebackup
set backupdir=~/.vim/backups/
set directory=~/.vim/swp/

" turn on line numbering
set nu

" show the current command in the lower right corner
set showcmd

" show the current mode
set showmode

" hide mouse pointer while typing
set mousehide

" grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" get rid of silly characters in seperators
set fillchars=""

" set tags so that it searches up the directory tree for a tags file not just in
" the current directory
set tags=tags;$HOME

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
"set guifont=Inconsolata\ Medium\ 18
set guifont=Inconsolata\ Medium\ 12

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
set foldmethod=marker
" Add a 2 character column to give visual indication of folds
set foldcolumn=2

" these mappings will open and close folds or create new folds using spacebar
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf
"}}}

"=====================Color Related Things====================="{{{
"colorscheme zenburn
"colorscheme mayansmoke "a nice light scheme
if has("gui_running")
  colorscheme neverland
else
  colorscheme zenburn
endif

" set t_Co so colors look better
"if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal'
"set t_Co=256
"endif

"if &term =~ '^\(xterm\|screen\)$'
"set t_Co=256
"endif
"}}}

"=====================Functions====================="{{{
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

function! GetClojureFold()
  if getline(v:lnum) =~ '^\s*(defn.*\s'
    return ">1"
  elseif getline(v:lnum) =~ '^\s*(defmacro.*\s'
    return ">1"
  elseif getline(v:lnum) =~ '^\s*(defmethod.*\s'
    return ">1"
  elseif getline(v:lnum) =~ '^\s*$'
    let my_cljnum = v:lnum
    let my_cljmax = line("$")

    while (1)
      let my_cljnum = my_cljnum + 1
      if my_cljnum > my_cljmax
        return "<1"
      endif

      let my_cljdata = getline(my_cljnum)

      " If we match an empty line, stop folding
      if my_cljdata =~ '^$'
        return "<1"
      else
        return "="
      endif
    endwhile
  else
    return "="
  endif
endfunction

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

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
"}}}

"=====================Key Mappings====================="{{{
" make <C-c> act like <ESC>
noremap <silent> <C-c> <ESC>

" always typing :W when I mean :w"
command! W :w

" make Y yank to end of line
nnoremap Y y$

" change the <Leader> character to ','
let mapleader = ','

" Edit and source the vimrc file
nnoremap <silent> <Leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <Leader>sv :so $MYVIMRC<CR>

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
nnoremap j gj
nnoremap k gk

" map J and K to go 10 lines up or down
nnoremap <silent> <C-j> 10j
nnoremap <silent> <C-k> 10k

" beginning and end of line
noremap <silent> <C-h> ^
noremap <silent> <C-l> $

" switch to last used buffer
nnoremap <silent> <Leader><leader> <c-^>

" Easy window navigation
" Don't really use these anymore
"nmap <A-h> <C-w>h
"nmap <A-j> <C-w>j
"nmap <A-k> <C-w>k
"nmap <A-l> <C-w>l
"nmap <A-c> <C-w>c

" when a omni-complete popup is visible use C-j and C-k to go up and down
" default map is C-p and C-n which is ok, leaving these here as examples
":inoremap <C-j> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-j>"<CR>
":inoremap <C-k> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-k>"<CR>

"This toggles the highlighting of searches - hit return in normal mode
nnoremap <silent> <CR> :set hlsearch!<CR>

" using tags, when over a word type alt-] to open the tag in a virtical split
nnoremap <silent> <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" map ,ss to spellcheck
nnoremap <silent> <Leader>ss :set spell!<CR>

" change directory to that of current file
nnoremap <silent> <Leader>cd :cd%:p:h<cr>

" clean up a file: (in this order)
" -remove \r (^M) characters
" -remove trailing white space
" -turn tabs into spaces
nnoremap <silent> <Leader>rs :silent! :call Preserve("%s/\r//g\|%s/\\s\\+$//e\|:retab")<CR>

" fix tab formatting of buffer
nnoremap <silent> <Leader>ff :silent! :call Preserve("normal gg=G")<CR>

" fix formatting of paragraph block: line length and tabs
nnoremap <silent> <Leader>fp :silent! :call Preserve("normal vipgq")<CR>

" toggle comment status of selected lines using NERDCommenter
noremap <silent> <Leader>cc ,c<space>

" mapping to copy from clipboard xclip program needed
nnoremap <silent> <Leader>v :r ! xclip -o<CR>

" run a test.sh script in the current directory
nnoremap <silent> <A-T> :!./test.sh<CR>

" open rails 'special' files in top window
nnoremap <silent> <Leader>gr :topleft :split config/routes.rb<cr>
nnoremap <silent> <Leader>gR :call ShowRoutes()<cr>
nnoremap <silent> <Leader>gg :topleft 100 :split Gemfile<cr>

" find directory of current file
cnoremap <silent> %% <C-R>=expand('%:h').'/'<cr>

" edit or view files in directory of current file
nnoremap <silent> <Leader>e :edit %%

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
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" close the current buffer, and close the current window
nnoremap <silent> <Leader>bd :BD<cr>\|<C-w>c

" Insert a hash rocket with <c-l>
inoremap <c-l> <space>=><space>
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

  autocmd VimEnter * unmap! <Tab>
augroup END
"}}}

"=====================Clojure Setup====================="{{{
function! TurnOnClojureSettings()
  setlocal foldexpr=GetClojureFold()
  setlocal foldmethod=expr

  " keymaps for sending lines to a REPL
  " configure the screen variables
  nmap <Leader>sc :call Screen_Vars()<CR>
  " send visual selection to screen
  vmap <Leader>sv "ry :call Send_to_Screen(@r)<CR>
  " send the paragraph to screen
  nmap <Leader>sp vip<Leader>sv
  " send entire file to screen
  nmap <Leader>sf :silent! :call Preserve("normal ggVG<Leader>sv")<CR>

  " hit 'm' to jump to a matching ()
  nmap m %
  vmap m %

  let vimclojure#WantNailgun = 0
  let vimclojure#NailgunClient = "/home/rob/bin/ng"
  let g:vimclojure#HighlightBuiltins = 1
  let g:vimclojure#ParenRainbow = 1
  let g:vimclojure#DynamicHighlighting = 1
  let g:paredit_mode = 0
endfunction

" autocommand setup for clojure
" define new group for myclojure
" and make sure to remove all autocommands
" for that group before defining them so when
" I source this file I don't get multiple autocmds
augroup myclojure
  autocmd!
  autocmd myclojure BufEnter *.clj call TurnOnClojureSettings()
augroup END

"}}}

"=====================LaTeX stuff====================="{{{
" set latexmk options
augroup mylatex
  autocmd!
  autocmd mylatex BufEnter *.tex let b:LatexBox_latexmk_options = "-pvc -pdfps"
  autocmd mylatex BufEnter *.tex let b:delimitMate_matchpairs = "(:),[:],{:},<:>,$:$"
augroup END
"}}}

"=====================Java stuff====================="{{{
" turn off java mappings
" only mappings so far should be in java_getset
"let g:no_java_maps = 1
"}}}

"=====================MiniBufExplorer settings====================="{{{
"Not using minibufexpl anymore
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplForceSyntaxEnable = 1
"let g:miniBufExplorerMoreThanOne = 0
"}}}

"=====================Command-t settings====================="{{{
" Open files with <leader>f
nnoremap <silent> <Leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found above.
nnoremap <silent> <Leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>

nnoremap <silent> <Leader>ga :CommandTFlush<cr>\|:CommandT app/assets<cr>
nnoremap <silent> <Leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
nnoremap <silent> <Leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
nnoremap <silent> <Leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
nnoremap <silent> <Leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
nnoremap <silent> <Leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
nnoremap <silent> <Leader>gs :CommandTFlush<cr>\|:CommandT app/assets/stylesheets<cr>
nnoremap <silent> <Leader>gj :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
nnoremap <silent> <Leader>gt :CommandTFlush<cr>\|:CommandT spec/<cr>
"}}}

"=====================NerdTree settings====================="{{{
let g:NERDTreeShowBookmarks=1
" can't seem to get this next setting to work properly
"let g:NERDTreeBookmarksFile='$HOME/.vim/NERDTreeBookmarks'

nnoremap <silent> <Leader>d :NERDTreeToggle<CR>
"}}}

"=====================TagList settings====================="{{{
let g:Tlist_Use_Right_Window=1
let g:Tlist_Auto_Open=0
let g:Tlist_Enable_Fold_Column=0
let g:Tlist_Compact_Format=0
let g:Tlist_WinWidth=28
let g:Tlist_Exit_OnlyWindow=1
let g:Tlist_File_Fold_Auto_Close=1
let g:tlist_clojure_settings='Lisp;f:function'

" toggle taglist window
nnoremap <silent> <Leader>l :TlistToggle<CR>
"}}}

"=====================TaskList settings====================="{{{
" toggle the tasklist window
" nmap <Leader>k :TaskList<CR>

"}}}

"=====================SuperTab settings====================="{{{
"SuperTab not used anymore, conflicted to much with DelimitMate and SnipMate
"let g:SuperTabDefaultCompletionType="context"
"let g:SuperTabMappingForward = '<c-space>'
"let g:SuperTabMappingBackward = '<s-c-space>'
"}}}

"=====================Syntastic settings====================="{{{
" turn on the little arrow that shows errors
let g:syntastic_enable_signs=1

" open/update errors window created by syntastic
nnoremap <C-S-e> :Errors<CR>
"}}}

"=====================DelimitMate settings====================="{{{
"not using delimitmate, parts of it are annoying
"let delimitMate_expand_cr = 1
"let delimitMate_expand_space = 1

" need to remap this as snipmate uses shift tab for another
" purpose, this mapping is so we can exit a delimiter without
" leaving and re-entering insert mode
"imap <C-Space> <Plug>delimitMateS-Tab
"}}}

"=====================SnipMate settings====================="{{{
"Not using snipmate, to hard to remap tab to what I want
"let g:snips_author = 'Robert McBride'
"}}}

"=====================ZenCoding settings====================="{{{
let g:user_zen_leader_key = '<c-y>'
"}}}

"=====================LustyJuggler settings====================="{{{
"Lusty seems to be fucking shit up so not using for now
"let g:LustyJugglerShowKeys = 'a'
"}}}
