# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

PROMPT='%{$fg_bold[blue]%}›%{$reset_color%}%{$fg_bold[red]%}›%{$reset_color%}%{$fg_bold[green]%}›%{$reset_color%} '
PS1=$'\n'"$PS1"
# Path to your oh-my-zsh installation.
export TERM="xterm-256color"
export ZSH="/Users/kevinsamoei/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="kevin"

# plugins
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  docker-compose
  golang 
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

function mkd() {
    mkdir -p "$@" && cd "$_";
}

clone() {
  git clone $1
  cd $(basename ${1%.*})
}

checkport(){ 
  lsof -n -i:$1 
}

export HOMEBREW_GITHUB_API_TOKEN=6b9f6540432c42a5b9009f313fc95608105eee8b
export PLATFORM=/Users/kevinsamoei/workspace/platform
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# docker_running=$(docker-machine ls | grep default)
# if [[ "$docker_running" == *"Stopped"* ]]
# then
#    docker-machine start default
#    eval "$(docker-machine env default)"
#    env | grep "DOCKER_HOST"
# elif [[ "$docker_running" == *"Running"* ]]
# then
#    eval "$(docker-machine env default)"
# fi
# autojump <https://github.com/wting/autojump>
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

alias lzd='lazydocker'
alias lzd='lazydocker'
alias gs='git status'
alias ga='git add .'
alias gp='git push'
alias gc='git commit -m'
alias dco='docker-compose'
alias gco='git checkout'
alias ll='exa -l'
alias chrome='open -a "/Applications/Google Chrome.app"'
alias idea='open -na "/Applications/IntelliJ Idea.app" --args "$@"'
alias w='cd ~/Workspace/'
alias p='cd ~/Projects/'
alias ez='vim $HOME/.zshrc'
alias gsu='git submodule update --init'
alias dvr='docker volume rm $(docker volume ls --filter dangling=true -q)'
alias c='clear'
# alias t='TERM=screen-256color-bce tmux'
alias vf='vim $(fzf)'
# alias vim="mvim -v"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change
export FZF_DEFAULT_OPTS='--height 100% --layout=reverse --border --preview "([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200"'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/Applications/flutter/bin/"
export GOPRIVATE="github.com/namely/*"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# if [[ $TMUX ]]; then source ~/.tmux-git/tmux-git.sh; fi
alias usage='top -l 1 | grep -E "^CPU|^Phys"'
alias cpu='top -F -R -o cpu'

# Namely kubectl aliases
alias kinta="kubectl --kubeconfig=/Users/kevinsamoei/.kube/int/kubeconfig --namespace=applications"
alias kstga="kubectl --kubeconfig=/Users/kevinsamoei/.kube/stage/kubeconfig --namespace=applications"
alias kproda="kubectl --kubeconfig=/Users/kevinsamoei/.kube/production/kubeconfig --namespace=applications"
alias kopsa="kubectl --kubeconfig=/Users/kevinsamoei/.kube/ops/kubeconfig --namespace=applications"

