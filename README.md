# My Vim config.

## Setup

**Backup and move your current `~/.vim` directory and `~/.vimrc` file as this will overwrite those**

Simply check this out to `$HOME/.vim`. Or copy and paste:

    git clone https://github.com/MrException/vim.git ~/.vim

Then run the `setup.sh`:

    cd ~/.vim && bash setup.sh

## What it does

This setup script is pretty simple. What it does:
- Copies the `vim-init` file to `~/.vimrc`
- Gets Vundle and puts it in the `~/.vim/bundle` directory
- Creates some empty folders needed for my config: `swap`, `backup`, and `undo` in your `~/.vim/` folder
- Starts vim and runs `:BundleInstall` to install all the plugins managed by Vundle

## Required

This config works best with some things set up:
- vim 7.4
- vim built with python support
- vim built with lua support
- python installed
- BeautifulSoup python lib (for JSON and XML pretting printing)
- ctags installed

Ok, these aren't really requirements. I run this on one server that only has Vim 7.2, and no lua, ctags, or
BeautifulSoup. It runs fine, but some settings report errors on startup, and some mappings don't work.
However, it is useable.
