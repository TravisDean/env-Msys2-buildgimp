# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# ~/.bashrc: executed by bash(1) for interactive shells.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the msys2 mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
#
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
# alias egrep='egrep --color=auto'              # show differences in colour
# alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
# alias ll='ls -l'                              # long list
# alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                              #

alias ls='ls --color --group-directories-first'
alias la='ls -A'
alias ll='ls -h -lv --group-directories-first'
alias lll='ls -A -h -lv --group-directories-first'
alias df='df -kTh'
alias du='du -hk'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias so=source
alias tree='tree -Csuh' # You'll need to get tree for this one
alias ..='cd ..'
alias home='cd ~'
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'


# Bookmarks are cool, but normally I forget to use them
#source ~/.local/bin/bashmarks.sh 

#~/configs/cowscript.sh | lolcat -F 0.004
# fortune | cowsay -f dragon-and-cow;echo  # Also requires fortune and cowsay

function ff() { find . -type f -iname '*'"$*"'*' ; }
# function cdfunct() {    cd "$1";  ls; }
# alias cd=cdfunct

#alias pkgfind='pkg-config --list-all | grep'
alias pacfind='pacman -Qs'
alias paclist='pacman -Qe && pacman -Qd'

# added by Anaconda3 2.1.0 installer
#export PATH="/home/travis/anaconda3/bin:$PATH"

#export PATH=$PATH:~/apps/MatlabInstall/bin

#export PS1="\e[01;35m \w \$ \e[m"
export PS1="\[\033[38;5;140m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;140m\]>\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

source ~/utils/autojump/bin/autojump.bash


# Enables advanced history logging
# are we an interactive shell?
if [ "$PS1" ]; then

  HOSTNAME=`hostname || echo unknown`

  # add cd history function
  [[ -f ${HOME}/bin/acd_func.sh ]] && . ${HOME}/bin/acd_func.sh
  # make bash autocomplete with up arrow
  bind '"\e[A":history-search-backward'
  bind '"\e[B":history-search-forward'
  ##################################
  # BEG History manipulation section

    # Don't save commands leading with a whitespace, or duplicated commands
    export HISTCONTROL=ignoredups

    # Enable huge history
    export HISTFILESIZE=9999999999
    export HISTSIZE=9999999999

    # Ignore basic "ls" and history commands
    export HISTIGNORE="ls:ls -al:ll:history:h:h[dh]:h [0-9]*:h[dh] [0-9]*"

    # Save timestamp info for every command
    export HISTTIMEFORMAT="[%F %T] ~~~ "

    # Dump the history file after every command
    shopt -s histappend
    #export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"
    export PROMPT_COMMAND="autojump_add_to_database ; history -a ; _loghistory ;"

    [[ -f ${HOME}/bin/a_loghistory_func.sh ]] && . ${HOME}/bin/a_loghistory_func.sh

    # Specific history file per host
    export HISTFILE=$HOME/.history-$HOSTNAME

    save_last_command () {
        # Only want to do this once per process
        if [ -z "$SAVE_LAST" ]; then
            EOS=" # end session $USER@${HOSTNAME}:`tty`"
            export SAVE_LAST="done"
            if type _loghistory >/dev/null 2>&1; then
                _loghistory
                _loghistory -c "$EOS"
            else
                history -a
            fi
            /bin/echo -e "#`date +%s`\n$EOS" >> ${HISTFILE}
        fi
    }
    trap 'save_last_command' EXIT

  # END History manipulation section
  ##################################

  export DOPRINTCDLS=false
  # Preload the working directory history list from the directory history
  if type -t hd >/dev/null && type -t cd_func >/dev/null; then
      for x in `hd 20` `pwd`; do cd_func $x ; done
  fi
  DOPRINTCDLS=true
fi
