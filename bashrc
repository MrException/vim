# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# setup path
SYS_PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH=$SYS_PATH:$HOME/bin:$HOME/scripts:$HOME/local/bin:$HOME/local/node/bin:$HOME/.rvm/bin
export NODE_PATH=$HOME/local/node:$HOME/local/node/lib/node_modules

# If not running interactively, don't do anything
if [[ -n "$PS1" ]]; then

  # change default editor to vi
  export EDITOR=/usr/bin/vi

  # making less (and in effect man) colourful
  export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
  export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
  export LESS_TERMCAP_me=$'\E[0m' # end mode
  export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
  export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode - info box export
  export LESS_TERMCAP_ue=$'\E[0m' # end underline
  export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

  # don't put duplicate lines in the history. See bash(1) for more options
  export HISTCONTROL=ignoreboth

  # append to the history file, don't overwrite it
  shopt -s histappend

  # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

  # a hack to get vim in the cli to look good in screen
  [ $TERM = "screen" ] && export TERM=rxvt-256color

  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi

  if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='\u@\h:\w\$ '
  fi
  unset color_prompt

  # Alias definitions.
  # You may want to put all your additions into a separate file like
  # ~/.bash_aliases, instead of adding them here directly.
  # See /usr/share/doc/bash-doc/examples in the bash-doc package.

  if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
  fi

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  else
    complete -cf sudo
  fi

  # source the keychain file for SSH keys
  if [ -z "$HOSTNAME" ]; then
    HOSTNAME=‘uname -n‘
  fi
  if [ -f $HOME/.keychain/$HOSTNAME-sh ]; then
    . $HOME/.keychain/$HOSTNAME-sh
  fi
  if [ -f $HOME/.keychain/$HOSTNAME-sh-gpg ]; then
    . $HOME/.keychain/$HOSTNAME-sh-gpg
  fi

  . ~/.bash_functions

fi

# This loads RVM into a shell session.
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  . "$HOME/.rvm/scripts/rvm"
else
  if [[ -s "/usr/local/rvm/scripts/rvm" ]]; then
    . "/usr/local/rvm/scripts/rvm"
  fi
fi
# This sets up RVM tab completion
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
