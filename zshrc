# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/
ZSH_CUSTOM=`dirname $0`

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [[ $(who am i) =~ \([-a-zA-Z0-9\.]+\) ]]; then
	ZSH_THEME="local-ssh"
elif [ "$(id -u)" = "0" ]; then
	ZSH_THEME="local-root"
else
	ZSH_THEME="local"
fi


EDITOR=/usr/bin/vim
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias lla="ls -lah --colors"
alias g=git
alias p=pdf
#alias vscode="visual-studio-code &|;"

pdf() {
	foxitreader "$*" &>/dev/null &|;
}

paththis() {
    PATH=$PATH:$(realpath ${1:-.})
}

unpaththis() {
    PATH=:$PATH:
    PATH=${PATH//:$(realpath ${1:-.}):/:}
    PATH=${PATH#:}
    PATH=${PATH%:}
}

git_id_databyte() {
	git config user.name SrTobi
	git config user.email "code.databyte@gmail.com"
}

git_id_jetbrains() {
	git config user.name "Tobias Kahlert"
	git config user.email "tobias.kahlert@jetbrains.com"
}

use_python() {
    case "$1" in
        "")
            echo "Specify the python version you want to use!"
            ;;
        "2")
            sudo rm /usr/bin/python
            sudo ln -s /usr/bin/python2 /usr/bin/python
            ;;
        "3")
            sudo rm /usr/bin/python
            sudo ln -s /usr/bin/python3 /usr/bin/python
            ;;
        *)
            echo "Unknown python version '$1'!"
            ;;
    esac
}

fpath+=${ZSH_CUSTOM}/completions


# Start or reuse ssh-agent
SSH_TMP_PATH="/tmp/ssh-agent-store/$USER-ssh.things"
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	mkdir -p $(dirname $SSH_TMP_PATH)
    ssh-agent > $SSH_TMP_PATH
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<$SSH_TMP_PATH)" > /dev/null
fi


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
#DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

export HISTFILE=~/.zsh_history  # ensure history file visibility
export HH_CONFIG=hicolor        # get more colors
bindkey -s "\C-r" "\eqhh\n"     # bind hh to Ctrl-r (for Vi mode check doc)

# Customize to your needs...
if [ -f ~/bin/zshstart ]; then
	source ~/bin/zshstart
fi
