# Setup zplug
export ZPLUG_HOME="${HOME}/.zsh.d/zplug"
export ZPLUG_CACHE_DIR="${HOME}/.cache/zplug"
export ZPLUG_REPOS="${HOME}/.local/share/zplug"
export ZPLUG_BIN="${HOME}/.local/bin"
source "${ZPLUG_HOME}/init.zsh"

# Language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# A decent editor
export EDITOR=vim

# Aliases
alias ls="ls ${lsflags}"
alias ll="ls ${lsflags} -l"
alias la="ls ${lsflags} -la"

# History settings
HISTFILE=~/.history-zsh
HISTSIZE=10000
SAVEHIST=10000
setopt append_history         # Multiple sessions, one history
setopt bang_hist              # CSH-style history expansion using !
setopt extended_history       # Write history in :start:elasped;command format
setopt hist_expire_dups_first # Expire duplicates first when trimming history
setopt hist_find_no_dups      # Don't repeat when searching history
setopt hist_ignore_dups       # Ignore duplicates
setopt hist_reduce_blanks     # Remove extra blanks from each command added to history
setopt hist_verify            # Don't execute immediately upon history expansion
setopt inc_append_history     # Write to history file immediately, not when shell quits
setopt share_history          # Share history among all sessions

# Tab completion
setopt complete_in_word # Expand previous words, not only the last one
setopt auto_menu        # Show completion menu on succesive tab presses
setopt autocd           # Change directory without cd

# Allow comments in the shell
setopt interactive_comments

# Use emacs bindings
bindkey -e

# Make C-w kill words properly
autoload -U select-word-style
select-word-style bash

# Home, end and delete keymapping
bindkey  '^[[1~' beginning-of-line
bindkey  '^[[4~' end-of-line
bindkey  '^[[3~' delete-char

# Patterns in searches
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# Add some plugs
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Basic stuff from zsh-users
zplug 'zsh-users/zsh-completions', defer:0
zplug 'zsh-users/zsh-autosuggestions', defer:2, on:'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:3, on:'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-history-substring-search', defer:3, on:'zsh-users/zsh-syntax-highlighting'

# Things from Oh My
zplug 'plugins/colored-man-pages', from:oh-my-zsh

# Powerlevel 10k theme
zplug 'romkatv/powerlevel10k', as:theme, depth:1

# Install plugs
if ! zplug check; then
   zplug install
fi

# Load plugs
zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source some private stuff
test -f "${HOME}/.zshrc_private" && source "${HOME}/.zshrc_private"
