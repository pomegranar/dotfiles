#===============================================================================
# Environment Variables
#===============================================================================
# NOTE: Source your ~/.profile or ~/.bash_profile for additional environment setup
# export EDITOR='nvim'
# export GIT_EDITOR='nvim'
export EDITOR='nvim'
export GIT_EDITOR='nvim'
export BAT_THEME="base16"
export NVM_DIR="$HOME/.nvm"

# uv path — added by `uv setup`
# (uv handles venvs, Python management, and pip replacement)

#===============================================================================
# Shell Configuration
#===============================================================================
# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_verify            # show command with history expansion before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# Vi mode
# bindkey -v
# export KEYTIMEOUT=1

# Basic auto/tab completion
autoload -U compinit

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST

# Timer for long running commands
function preexec() {
  timer=$(($(gdate +%s%3N 2>/dev/null || date +%s)))
}

function format_elapsed_time() {
  local elapsed_ms=$1
  local elapsed_s=$((elapsed_ms / 1000))

  if (( elapsed_s >= 60 )); then
    local mins=$((elapsed_s / 60))
    local secs=$((elapsed_s % 60))
    printf "%dm%ds" $mins $secs
  elif (( elapsed_s >= 2 )); then
    printf "%.3fs" $((elapsed_ms / 1000.0))
  else
    printf "%dms" $elapsed_ms
  fi
}

function precmd() {
  if [ $timer ]; then
    now=$(($(gdate +%s%3N 2>/dev/null || date +%s)))
    elapsed=$(($now-$timer))
    if [ $elapsed -gt 10 ]; then  # Show if greater than 100ms
      formatted_time=$(format_elapsed_time $elapsed)
      RPS1="%F{yellow}󱦟 Took ${formatted_time}%f"
    else
      RPS1=""
    fi
    unset timer
  else
    RPS1=""
  fi
  vcs_info
}

#===============================================================================
# Aliases - File & Directory Navigation
#===============================================================================
alias l="gols -c -s -T"
alias gols="gols -i"
alias la="gols -c -s -T -a"
alias tree="tree -I .git --gitignore -a -sh -C"
alias see="bat -P --theme base16"
alias edit="micro"
alias dush="du -sh"
alias nv="nvim"
alias lv="lvim"

#===============================================================================
# Aliases - Development & Tools
#===============================================================================
alias penv="source .venv/bin/activate"
alias sql="mycli -u root"
alias ff="fastfetch"

#===============================================================================
# Aliases - Git
#===============================================================================
alias gitnuke='git fetch --prune && git reset --hard @{u} && git clean -fdx'
alias gpnr="git pull --no-rebase"
alias ga="git add -A "
alias gc="git commit"
alias gcm="git commit -m "

#===============================================================================
# Path Configuration
#===============================================================================
typeset -U path PATH  # Remove duplicates in PATH

# Add yarn global bin to PATH only if yarn is installed
if (( $+commands[yarn] )); then
    path+=("$(yarn global bin)")
fi

export PATH="$HOME/.stack/programs/*/*/bin:$PATH"

#===============================================================================
# Custom Functions
#===============================================================================
countfiles() {
  git ls-files --others --cached --exclude-standard \
    | grep '\.' \
    | awk -F. '{print $NF}' \
    | awk '{count[$1]++} END {for (ext in count) print count[ext], ext}' \
    | sort -nr
}

nb() {
  # Open most recent markdown file from notebook directory
  local notebook_dir="${NOTEBOOK_DIR:-$HOME/Desktop/Notebook}"
  cd "$notebook_dir"
  local file
  file="$(ls -t *.md 2>/dev/null | head -n 1)"
  if [[ -n "$file" ]]; then
    nvim "$file"
  else
    echo "No .md files found in $notebook_dir"
  fi
}

flip() { ((RANDOM%2)) && echo heads || echo tails }

#===============================================================================
# Key Bindings & Completion
#===============================================================================
# Better history navigation
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Use modern completion system
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:cd:*' tag-order '!' directories

# Run compinit once per day and only check cached .zcompdump once per day
if [[ -z ${__COMPINIT_DONE:-} ]]; then
  autoload -Uz compinit
  if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
      compinit
  else
      compinit -C
  fi
  __COMPINIT_DONE=1
fi

#===============================================================================
# Shell Integrations & Plugins
#===============================================================================
# ZSH autosuggestions
if [[ -f "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  # Debian/Ubuntu
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  # Fedora
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ZSH syntax highlighting
if [[ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  # Debian/Ubuntu
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  # Fedora
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#===============================================================================
# Tool Integrations
#===============================================================================
eval "$(starship init zsh)"
eval $(thefuck --alias)

# NVM Lazy Loading
load_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Only define lazy loader wrappers if the real command is not already available
if ! command -v nvm >/dev/null 2>&1; then
  nvm() {
    load_nvm
    unset -f nvm
    nvm "$@"
  }
fi
if ! command -v node >/dev/null 2>&1; then
  node() {
    load_nvm
    unset -f node
    node "$@"
  }
fi
if ! command -v npm >/dev/null 2>&1; then
  npm() {
    load_nvm
    unset -f npm
    npm "$@"
  }
fi
if ! command -v yarn >/dev/null 2>&1; then
  yarn() {
    load_nvm
    unset -f yarn
    yarn "$@"
  }
fi
if ! command -v pnpm >/dev/null 2>&1; then
  pnpm() {
    load_nvm
    unset -f pnpm
    pnpm "$@"
  }
fi

#===============================================================================
# uv Configuration
#===============================================================================
# uv is automatically initialized by `uv setup` (sh/zsh hook).
# It manages Python versions, virtual environments, and acts as a pip replacement.
#
# Common uv usage:
#   uv venv            — create a virtual environment
#   uv pip install ... — install packages into the active venv
#   uv run ...         — run a command in the venv
#   uv sync            — install from pyproject.toml/uv.lock
#
# For shell integration, run: uv setup --shell zsh --shell-command zsh
