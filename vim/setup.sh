#!/bin/bash

root=`pwd`

# create the backups and swap file directories
[ ! -e backups ] && mkdir backups
[ ! -e swp ] && mkdir swp

# remove everything
echo "Removing files..."
rm -rf autoload
rm -rf vim-pathogen
rm -rf bundle
rm -rf vimclojure
echo "Done removing files."

# install pathogen and ln -s it
git clone http://github.com/tpope/vim-pathogen.git
ln -s vim-pathogen/autoload ./

# create bundle directory for storing plugins
mkdir bundle

# first vimclojure since it's a special case
# not using vimclojure for a while since not doing clj dev
#hg clone http://bitbucket.org/kotarak/vimclojure
#ln -s ~/.vim/vimclojure/vim bundle/vimclojure

cd bundle

# now git
#git clone http://github.com/tpope/vim-commentary.git
git clone http://github.com/tpope/vim-repeat.git
git clone http://github.com/tpope/vim-endwise.git
#git clone http://github.com/tpope/vim-rails.git
git clone http://github.com/tpope/vim-surround.git
git clone http://github.com/tpope/vim-fugitive.git
git clone http://github.com/scrooloose/nerdtree.git
git clone http://github.com/scrooloose/syntastic.git
git clone http://github.com/scrooloose/nerdcommenter.git
git clone http://github.com/mattn/zencoding-vim.git
git clone http://github.com/majutsushi/tagbar.git
git clone http://github.com/kien/ctrlp.vim.git
git clone http://github.com/mileszs/ack.vim.git
git clone http://github.com/michaeljsmith/vim-indent-object.git
git clone http://github.com/vim-scripts/ZoomWin.git
git clone http://github.com/vim-scripts/matchit.zip.git
#git clone http://github.com/godlygeek/tabular.git
#git clone http://github.com/vim-scripts/vimwiki.git
git clone http://github.com/Lokaltog/powerline.git
#git clone http://github.com/Lokaltog/vim-powerline
git clone http://github.com/vim-scripts/closetag.vim.git
git clone http://github.com/dbarsam/vim-bufkill.git
git clone http://github.com/vim-scripts/YankRing.vim.git

git clone http://github.com/ervandew/supertab.git

# colors
git clone http://github.com/altercation/vim-colors-solarized.git

# faster movement
git clone http://github.com/Lokaltog/vim-easymotion.git
git clone http://github.com/goldfeld/vim-seek.git

# snipmate and deps
git clone http://github.com/SirVer/ultisnips.git
#git clone http://github.com/tomtom/tlib_vim.git
#git clone http://github.com/MarcWeber/vim-addon-mw-utils.git
#git clone http://github.com/garbas/vim-snipmate.git
#git clone http://github.com/honza/snipmate-snippets

git clone http://github.com/vim-scripts/dbext.vim.git

# Plugins to autoclose brackets and what not
#git clone http://github.cmm/vim-scripts/AutoClose.git
git clone http://github.com/Raimondi/delimitMate.git
#git clone http://github.com/kana/vim-smartinput.git

# syntax highlighting, formatting, etc.
git clone http://github.com/vim-ruby/vim-ruby.git
#git clone http://github.com/tpope/vim-markdown.git
#git clone http://github.com/tpope/vim-haml.git
git clone http://github.com/itspriddle/vim-jquery.git
git clone http://github.com/pangloss/vim-javascript.git
#git clone http://github.com/kchmck/vim-coffee-script.git
#git clone http://github.com/digitaltoad/vim-jade.git
#git clone http://github.com/vim-scripts/nginx.vim.git
#git clone http://github.com/vim-scripts/nxc.vim.git

##############
# No longer used plugins
# that I may use again
##############

# possibilities
# git clone https://github.com/chrisbra/NrrwRgn.git

# open a scratch buffer, just use :enew now
# git clone http://github.com/duff/vim-scratch.git

# neet idea, but I haven't ever used it
#git clone http://github.com/superjudge/tasklist-pathogen.git

# just clutters up my status bar
#git clone http://github.com/csexton/rvm.vim.git

# trying not to use minibufexpl for now
#git clone http://github.com/fholgado/minibufexpl.vim.git

# git plugins, not using them right now
#git clone http://github.com/int3/vim-extradite.git

# most used list
#git clone http://github.com/vim-scripts/mru.vim.git

# vicle, send code to a screen window
#git clone http://github.com/vim-scripts/Vicle.git

# lusty juggler, for switching buffers
#git clone http://github.com/sjbach/lusty.git

# some plugins for java
#git clone http://github.com/vim-scripts/java_getset.vim.git
#git clone http://github.com/vim-scripts/javacomplete.git

# for editing and formatting csv
#git clone http://github.com/chrisbra/csv.vim.git

# back to root vim dir
cd $root 

# link syntax checkers
cd bundle/syntastic/syntax_checkers
ln -s ../../../syntax_checkers/* ./
cd $root
