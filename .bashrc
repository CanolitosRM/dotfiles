# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias dot_files='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias sysdoc='nvim ~/.local/share/doc/void_ops_manual.txt'
# Soporte Tmux para XDG
alias tmux='tmux -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'

# === GPG con estándar XDG ===
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GPG_TTY=$(tty)

#PS1='\[\e[1;32m\]\u\
#\[\e[0;36m\]@\
#\[\e[1;32m\]\h \
#\[\e[0;36m\][\
#\[\e[1;34m\]\w\
#\[\e[0;36m\]]\n\
#\[\e[0;33m\]\$\
#\[\e[0;36m\] --> \[\e[0m\]'

PS1='\[\e[1;33m\]\u@\h [\w]\n\$ > \[\e[0m\]'
PS2='\[\e[0;33m\]       > \[\e[0m\]'
