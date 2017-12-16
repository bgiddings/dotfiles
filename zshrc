# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistfile
HISTSIZE=5000
SAVEHIST=5000
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

source ~/.zsh/zsh_ps1
source ~/.zsh/zsh_aliases
source ~/.zsh/zsh_opts

name="$(uname -s)"
case "${name}" in
    Linux*)
        source ~/.zsh/zsh_linux
        ;;
    Darwin*)
        source ~/.zsh/zsh_mac
        ;;
esac


test -e ~/.dircolors && eval `dircolors -b ~/.dircolors`

# Nuke - _ / [ and ] from wordchars
WORDCHARS=${WORDCHARS//[-\/_\[\]]/} 
# WORDCHARS="${WORDCHARS:s#/#}"

#export EDITOR='emacs'   # this runs in a GUI.
export EDITOR='emacs -nw'

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
# Allow meta-m to copy the last word of the current line, or with meta-. to 
# copy words from pervious lines
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word


export SPROMPT="Correct %R to %r? ([y]es, [n]o, [a]bort, [e]dit) "

autoload -U bashcompinit
bashcompinit

