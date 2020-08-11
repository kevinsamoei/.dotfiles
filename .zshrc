# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export TERM="xterm-256color"
export ZSH="/Users/kevinsamoei/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="kevin"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=$PATH:$GOPATH/bin
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
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status dir vcs newline)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RUBY_SHOW_ENGINE=true
# POWERLEVEL9K_RUBY_SHOW_VERSION=true
# POWERLEVEL9K_MODE='nerdfont-complete'
# POWERLEVEL9K_MODE='awesome-patched'
# source  ~/powerlevel9k/powerlevel9k.zsh-theme
# pure
# autoload -U promptinit; promptinit
# prompt pure
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
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
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change

# added by travis gem
[ -f /Users/kevinsamoei/.travis/travis.sh ] && source /Users/kevinsamoei/.travis/travis.sh
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
alias t='tmux'
alias vf='vim $(fzf)'
# alias vim="mvim -v"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change
export FZF_DEFAULT_OPTS='--height 100% --layout=reverse --border --preview "([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200"'
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/Applications/flutter/bin/"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# if [[ $TMUX ]]; then source ~/.tmux-git/tmux-git.sh; fi
alias usage='top -l 1 | grep -E "^CPU|^Phys"'
alias cpu='top -F -R -o cpu'

