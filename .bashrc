#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


if [ -f /usr/bin/fastfetch ]; then
  fastfetch
fi



# Alias's

alias rm='gio trash'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias ds='sudo systemctl start docker'

#PS1='[\u@\h \W]\$ '
# PS1='\[\e[35m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]:\$ '
PS1='\[\e[35m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '
export PATH=$HOME/.local/bin:$PATH

eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


alias air='~/go/bin/air'

# Turso
export PATH="$PATH:/home/vivek/.turso"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

