[[ $- != *i* ]] && return

## Aliases

alias ls="ls --color=auto"

## Options

setopt AUTO_CD
setopt AUTO_PUSHD

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

## Functionality

autoload -U compinit
compinit

pgrep -u $USER gpg-agent > /dev/null || gpg-agent --daemon > ~/.gpgagent
test -e ~/.gpgagent && test -z $SSH_AUTH_SOCK && source ~/.gpgagent

source /usr/share/autojump/autojump.zsh

bindkey -v

## Variables

if test -z $SSH_CONNECTION; then promptcolor=green; else; promptcolor=yellow; fi
eval $(dircolors ~/.dircolors)

vicolor="blue"
vimode="INSERT"

PROMPT="%F{${promptcolor}}%n@%m %F{blue}%3~ %F{red}%B%#%f%b "
RPROMPT="%F{white}%K{blue}%B INSERT %b%k%f"
PATH=$PATH:~/.local/bin:~/perl5/bin
EDITOR=vim

export PERL5LIB="/home/fwilson/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/home/fwilson/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"/home/fwilson/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/fwilson/perl5"

## Functions

function dotenv {
    (
        test -e .env && source .env
        eval $@
    )
}

function zle-line-init zle-keymap-select rprompt {
    case $KEYMAP in
        vicmd) vimode="NORMAL"; vicolor="green";;
        *) vimode="INSERT"; vicolor="blue";;
    esac
    RPROMPT="%F{white}%K{${vicolor}}%B ${vimode} %b%k%f"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
