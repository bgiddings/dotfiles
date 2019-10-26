# Reserved for Root
# local red="%{$fg_bold[red]%}" # This isn't red in solarized
local red="%{$fg[red]%}"

# Used to distinguish hosts
# In solarized fg[] are close to the real colours
local blue="%{$fg[blue]%}"
local cyan="%{$fg[cyan]%}"
local green="%{$fg[green]%}"
local magenta="%{$fg[magenta]%}"
local white="%{$fg[white]%}"
local yellow="%{$fg[yellow]%}"

# Not a colour
local reset="%{$reset_color%}"

local -a color_array
color_array=($green $cyan $yellow $blue $magenta $white)

# Special settings
local username_normal_color=$white
local username_root_color=$red
local hostname_root_color=$red

# calculating hostname color with hostname characters

# Convert characters to their ASCII numbers
ord() {
  LC_CTYPE=C printf '%d' "'$1'"
}

let count=0;               # A running count of characters
local tmp=`hostname`;
while [ -n "$tmp" ]; do
  local rest="${tmp#?}";        # All but the first character of the string
  local first="${tmp%"$rest"}"; # Remove $rest leaving only the first char
  local char=$(ord $first);     # Get the character code for the first char
  count=$(($count + $char));    # Add the current char to the running total
  tmp="$rest";
done

# Get an array index using the 6 valid host colors from 1 to 6 (not 0 to 5)
let idx=$(($count % 6 + 1));

local hostname_normal_color=$color_array[$idx]

# for i in `hostname`; local hostname_normal_color=$color_array[$[((#i))%6+1]]
local -a hostname_color
hostname_color=%(!.$hostname_root_color.$hostname_normal_color)

local username_command="%n"
local hostname_command="%m"

local username_output="%(!..$username_normal_color$username_command$reset@)"
local hostname_output="$hostname_color$hostname_command$reset"
local jobs_bg="${red}fg: %j$reset"
local last_command_output="%(?.%(!.$red.$green).$yellow)"

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="$blue%%"
ZSH_THEME_GIT_PROMPT_MODIFIED="$red*"
ZSH_THEME_GIT_PROMPT_ADDED="$green+"
ZSH_THEME_GIT_PROMPT_STASHED="$blue$"
ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="$green="
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=">"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="<"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$red<>"

PROMPT='$username_output$hostname_output%1(j. [$jobs_bg].)%(?,%{$fg[green]%},%{$fg[red]%})%% '
RPROMPT='$white%3~'
GIT_PROMPT='$(out=$(git_prompt_info)$reset$(git_prompt_status)$reset$(git_remote_status);if [[ -n $out ]]; then printf %s " $white($magenta$out$white)$reset";fi)'
RPROMPT+="$GIT_PROMPT"
PS2='%_>'

