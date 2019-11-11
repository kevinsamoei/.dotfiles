# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export TERM="xterm-256color"
export ZSH="/Users/kevinsamoei/.oh-my-zsh"

ZSH_THEME="kevin"

plugins=(
  git
  docker
  docker-compose
  golang 
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

# shortcut for mkdir && cd
function mkd() {
    mkdir -p "$@" && cd "$_";
}

# better clone. Runs git clone && cd
clone() {
  git clone $1
  cd $(basename ${1%.*})
}
# uncomment this to enable pure prompt
# see: https://github.com/sindresorhus/pure
# autoload -U promptinit; promptinit
# prompt pure

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# auto start docker machine
docker_running=$(docker-machine ls | grep default)
if [[ "$docker_running" == *"Stopped"* ]]
then
    docker-machine start default
    eval "$(docker-machine env default)"
    env | grep "DOCKER_HOST"
elif [[ "$docker_running" == *"Running"* ]]
then
    eval "$(docker-machine env default)"
fi

# autojump <https://github.com/wting/autojump>
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# added by travis gem
[ -f /Users/kevinsamoei/.travis/travis.sh ] && source /Users/kevinsamoei/.travis/travis.sh

# aliases
# https://github.com/jesseduffield/lazydocker
alias lzd='lazydocker'

alias gs='git status'
alias ga='git add .'
alias gp='git push'
alias gc='git commit -m'
alias dco='docker-compose'
alias gco='git checkout'
alias gsu='git submodule update --init'
# https://github.com/ogham/exa
alias ll='exa -l'
# https://github.com/sharkdp/bat
alias cat='bat'
alias chrome='open -a "/Applications/Google Chrome.app"'
alias w='cd ~/Workspace/'
alias p='cd ~/Projects/'
alias ez='vim $HOME/.zshrc'
alias dvr='docker volume rm $(docker volume ls --filter dangling=true -q)'
alias c='clear'

export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:$HOME/.rvm/bin"
