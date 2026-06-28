# ==============================================================================
# INSTANT PROMPT (Powerlevel10k)
# Must stay near the top — before any output-generating code
# ==============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ==============================================================================
# OH MY ZSH
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)

source $ZSH/oh-my-zsh.sh


# ==============================================================================
# HISTORY
# ==============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE   # don't save commands that start with a space (useful for secrets)
setopt HIST_VERIFY         # show the expanded command before running a history substitution


# ==============================================================================
# COMPLETION
# ==============================================================================
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive tab completion


# ==============================================================================
# PATH
# ==============================================================================
export PATH="$PATH:/Users/neil/.local/bin"          # pipx
export PNPM_HOME="/Users/neil/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac


# ==============================================================================
# PYTHON — pyenv
# (conda is also present; run `conda config --set auto_activate_base false`
#  to stop it winning the python race on startup)
# ==============================================================================
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# ==============================================================================
# PYTHON — conda (Miniconda)
# ==============================================================================
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
elif [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
  . "/opt/miniconda3/etc/profile.d/conda.sh"
else
  export PATH="/opt/miniconda3/bin:$PATH"
fi
unset __conda_setup


# ==============================================================================
# NODE — nvm (lazy-loaded for faster startup)
# ==============================================================================
export NVM_DIR="$HOME/.nvm"

nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
  nvm "$@"
}
node() { nvm; node "$@"; }
npm()  { nvm; npm  "$@"; }
npx()  { nvm; npx  "$@"; }


# ==============================================================================
# OCAML — opam
# ==============================================================================
[[ ! -r '/Users/neil/.opam/opam-init/init.zsh' ]] || \
  source '/Users/neil/.opam/opam-init/init.zsh' > /dev/null 2>&1


# ==============================================================================
# ALIASES
# ==============================================================================
alias l='ls -lah'               # detailed directory listing
alias tmuxcreate='tmux new -s'
alias tmuxattach='tmux attach'
alias tmuxkill='tmux kill-session -t'
alias py="python3"
alias gl="git pull"
alias gs="git status"
alias gd="git diff"
alias gco="git checkout"
alias grh="git reset"
alias gbr='git branch'
alias gsw='git switch'
alias -g ...='../..'
alias desk='cd ~/Desktop'
alias dev='cd ~/Dev'
alias class='cd ~/Classes'
alias learn='cd ~/Learning'
alias leet='cd ~/Learning/Interview-prep/Leetcode-problems'
alias gco='git checkout $(git branch | fzf | sed "s/^[* ]*//")'
alias cses='cd ~/Learning/Interview-prep/cses-problems/'
alias commitX='cd ~/misc-dev-stuff/new-cron-script/'
alias website='cd ~/Desktop/Port/website/'
alias cur='cd ~/cur/'
alias 

# venv shortcut 
venv() {
  if [ -d ".venv" ]; then
    source .venv/bin/activate
  else
    echo "No .venv found in current directory"
  fi
}



# ==============================================================================
# SHELL OPTIONS
# ==============================================================================
setopt interactivecomments   # allow # comments in interactive shell
bindkey '\ew' backward-kill-line  # Option+W deletes from cursor to start of line


# ==============================================================================
# POWERLEVEL10K
# ==============================================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ==============================================================================
# SYNTAX HIGHLIGHTING — must be sourced last
# ==============================================================================
source ~/zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
