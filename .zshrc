export PATH=$HOME/bin:/usr/local/bin:$PATH

# colors
export TERM="xterm-256color"
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

setopt share_history

# prompt
autoload -U colors && colors
PROMPT="%{$fg_bold[blue]%}›%{$reset_color%}%{$fg_bold[red]%}›%{$reset_color%}%{$fg_bold[green]%}›%{$reset_color%} "
PS1=$'\n'"$PS1"

# plugins
fpath=(~/.zsh/completion $fpath)

autoload -U compinit && compinit

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

# helper functions
function denter(){
 if [ -z "$1" ]; then echo "\nPlease:\n denter [ContainerName]\n\nView:\n docker container ls\n" ;else docker exec -it "$1" /bin/bash ;fi;
}

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

# aliases
alias gs='git status'
alias ga='git add .'
alias gp='git push'
alias gc='git commit -m'
alias dco='docker-compose'
alias gco='git checkout'
alias chrome='open -a "/Applications/Google Chrome.app"'
alias ez='vim $HOME/.zshrc'
alias gsu='git submodule update --init'
alias dvr='docker volume rm $(docker volume ls --filter dangling=true -q)'
alias c='clear'
alias usage='top -l 1 | grep -E "^CPU|^Phys"'
alias cpu='top -F -R -o cpu'

# paths
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kevin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kevin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kevin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kevin/google-cloud-sdk/completion.zsh.inc'; fi

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export GOPRIVATE=github.com/helloturbine/app
