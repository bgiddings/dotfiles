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
zstyle :compinstall filename '$HOME/.zshrc'
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
source ~/.zsh/zsh_comp_specific

test -e ~/.dircolors && eval `dircolors -b ~/.dircolors`

# Nuke - _ / [ and ] from wordchars
WORDCHARS=${WORDCHARS//[-\/_\[\]]/} 
# WORDCHARS="${WORDCHARS:s#/#}"

#export EDITOR='emacs'   # this runs in a GUI.
export EDITOR='emacs -nw'

export SPROMPT="Correct %R to %r? ([y]es, [n]o, [a]bort, [e]dit) "

autoload -U bashcompinit
bashcompinit

