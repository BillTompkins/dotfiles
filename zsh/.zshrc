# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="random"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
)

if [[ $(uname) == "Darwin" ]]; then
  plugins+=brew
  plugins+=osx
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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

if [[ "${HOST}" == *.local && "${USER}"=bill* ]] ; then
    DEFAULT_USERNAMES="bill:billt:btompkins:billtompkins"
else
    # try to inherit the default username list via LC_USER (sent through SSH), separated by colons
    DEFAULT_USERNAMES=${LC_USER}
    if [[ ${#DEFAULT_USERNAMES} -eq 0 ]] ; then
        DEFAULT_USERNAMES=${USER}
    fi
fi
export DEFAULT_USERNAMES
unset LC_USER

local -a default_username_list ; default_username_list=("${(@s/:/)DEFAULT_USERNAMES}")

if [[ ${default_username_list[(r)${USER}]} == ${USER} ]] ; then
    export USER_IS_DEFAULT=true
    export DEFAULT_USER=${USER}
fi

local title_user
if [ $USER_IS_DEFAULT ] ; then
    title_user=""
else
    title_user=${USER}@
fi

local title_host
if [[ "${HOST}" == *.local ]] ; then
    title_host=""
else
    title_host=${HOST}
fi

ZSH_TITLE_PREFIX="${title_user}${title_host}"
if [[ $ZSH_TITLE_PREFIX != "" ]] ; then
    ZSH_TITLE_PREFIX="${ZSH_TITLE_PREFIX}: "
fi
export ZSH_TITLE_PREFIX

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_unique_from_left"
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_DIR_NOT_WRITABLE_BACKGROUND='red'

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status root_indicator background_jobs time)
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='236'

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.functions ] && source ~/.functions
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.exports ] && source ~/.exports

[ -f ~/.localrc ] && source ~/.localrc
