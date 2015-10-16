setopt histignorealldups sharehistory
export TERM=screen-256color

# Keep lots of lines of history within the shell and save it to ~/Misc/ZSH_HISTORY
HISTFILESIZE=1000000
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/Misc/ZSH_HISTORY

# Use modern completion system
autoload -Uz compinit
compinit
# Uhh, some built-in completion magic
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# http://stackoverflow.com/a/27643846/1223693
zstyle -e ':completion::complete:-command-::executables' ignored-patterns '
  [[ "$PREFIX" == ./* ]] && {
    local -a tmp; set -A tmp ./*(/)
    : ${(A)tmp::=${tmp// /\\ }}
    reply=(${(j:|:)tmp})
  }
'
# http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# urxvt shenanigans
function title() { printf '\33]2;%s\007' "$1" }

# fun
alias ipbt="~/Programs/ipbt/ipbt"
alias sl="sl -e"
alias cmatrix="cmatrix -b -u 9"
alias xcowsay="xcowsay -f monospace"
alias dwarf="~/Games/df/df"
alias nao="ssh nethack@nethack.alt.org"
alias knao='ps ax | grep "ssh nethac[j-l]" | awk "{print \$1}" | xargs kill'
alias bsdgames="apt show bsdgames | tail -n6"
function atcrec() {
    ttyrec "$(date "+atc_%F_%T.ttyrec")" -e "TERM=xterm atc -g ${1:-default}"
}

# system toggles
# true or false
alias automount="gsettings set org.gnome.desktop.media-handling automount"
# on or off
alias monitor="xset dpms force"
# no args
alias lock="/etc/acpi/lid.sh"

# system status
alias ipaddr="ifconfig -a | grep inet"
alias battery="upower -d | grep percentage"

# etc
alias say="spd-say"
alias keyftp="ftp ftp.keyboardfire.com"
alias keyerr="echo 'get stats/cgi_error_log -' | ftp ftp.keyboardfire.com"
alias ostrich="~/Code/python/Ostrich/lib/ostrich.py"
alias snowman="~/Code/snowman/snowman/lib/snowman"
alias macaroni="~/Code/rust/macaroni-lang/target/debug/macaroni-lang"
alias ws='watch -n0.1 echo '"'"'${LINES}x$COLUMNS'"'"
alias pgrep='pgrep -a'
alias ascii='if [ -t 0 ]; then man ascii; else; paste <(man ascii | grep Oct -A 47) <(man ascii | grep Oct -A 66 | tail -n 18; for (( i=0; i<3; i++ )); do head -c79 < /dev/zero | tr "\0" " "; echo; done)  <(man ascii | grep Tables -A 20) |  zenity --text-info --font="monospace 8" --width=1920 --height=1080; fi'

setopt interactivecomments

# PROMPTS
PS1="%K{blue}%F{white}%n@%m%f%k:%B%F{cyan}%(4~|...|)%3~%F{white}%(!.#.$) %b%f%k"
#RPS1="%*"

# AFL
export PATH=$PATH:/home/llama/Programs/afl-1.83b
alias cpugov-perf='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias cpugov-ondemand='echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'

# Google App Engine
export PATH=$PATH:/home/llama/Programs/google_appengine/
