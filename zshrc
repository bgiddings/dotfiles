# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistfile
HISTSIZE=2000
SAVEHIST=2000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
# zstyle ':completion:*' max-errors 2
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/Users/bgiddings/.zshrc'
zstyle ':completion:*' hosts off

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Show a cursor-controlled menu for completion if there are lots of possible results (long)
# zstyle ':completion:*' menu select=long
zstyle ':completion:*' menu select

# Completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path .zsh/.comp_cache

# Ignore completion functions for commands you don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# Force a menu for kill
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# Allow cdable_vars to be set without expanding users
zstyle ':completion::complete:cd::' tag-order '! users' -

stty -ixon -ixoff 2>/dev/null # really, no flow control.

source ~/.zsh/zsh_ps1_merc
source ~/.zsh/zsh_aliases_merc
source ~/.zsh/zsh_opts_merc
source ~/Documents/Development/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# source /etc/bash_completion.d/g4d

# https://github.com/zsh-users/zsh-syntax-highlighting
export PATH=~/bin:/opt/local/bin:/opt/local/sbin:/usr/local/google/home/bgiddings/Documents/Development/go_appengine:$HOME/homebrew/bin:$PATH

# Nuke - _ / [ and ] from wordchars
WORDCHARS=${WORDCHARS//[-\/_\[\]]/} 
# WORDCHARS="${WORDCHARS:s#/#}"

### Local stuff ###
alias merx='ssh merx.hot'
alias gemacs='emacs -nw --load ~/.gemacs'

export P4CONFIG=.p4config
export P4DIFF="/home/build/google3/devtools/scripts/p4diff -uw"
export P4MERGE=/home/build/eng/perforce/mergep4.tcl

#export EDITOR='emacs'   # this runs in a GUI.
export EDITOR='emacs -nw'

# ZSH Completions for Brew (MacOS only)
fpath=(/Users/bgiddings/homebrew/share/zsh-completions $fpath)

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down