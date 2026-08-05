# zsh specific

# history
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

# completions
mkdir -p "$XDG_CACHE_HOME/zsh"
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
autoload -Uz bashcompinit && bashcompinit
. /usr/share/bash-completion/completions/yt-dlp
compdef _precommand doas

eval "$(dircolors)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

rehash() {
  builtin rehash
  local _cmd
  for _cmd in ${(k)commands}; do
    [ -d "${commands[$_cmd]}" ] && unhash -- "$_cmd"
  done
}

dot-slash-complete() {
  if [ "$BUFFER" = "." ] && [ "$CURSOR" -eq 1 ]; then
    LBUFFER+="/"
  fi
  zle expand-or-complete
}
zle -N dot-slash-complete

# fzf
export FZF_CTRL_R_OPTS="--height 100% --reverse --prompt='$ ' --no-info --border=none --margin=3,2 --padding=2 --exact"
. /usr/share/fzf/key-bindings.zsh

# binds
bindkey -e # emacs binds, which is what bash uses
WORDCHARS=''

bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
bindkey '^H' backward-kill-word
bindkey '^[^?' backward-kill-word
bindkey '^[c' capitalize-word

bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

bindkey '^I' dot-slash-complete
