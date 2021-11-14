# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt inc_append_history
setopt share_history

bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

# End of lines added by compinstall

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

zinit load agkozak/zsh-z

zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
        OMZP::colored-man-pages


autoload -Uz compinit
compinit
zinit cdreplay -q

autoload -U select-word-style
select-word-style bash

# >>> theme >>>

autoload -U promptinit; promptinit

zstyle :prompt:pure:prompt:success color white
zstyle :prompt:pure:path color green
zstyle :prompt:pure:user color '#888888'
zstyle :prompt:pure:host color '#888888'
# <<< theme <<<

# >>> custom >>>
export RUSTUP_UPDATE_ROOT="https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup"
export RUSTUP_DIST_SERVER="https://mirrors.tuna.tsinghua.edu.cn/rustup"
# <<< custom <<<

# >>> alias >>>
case "$OSTYPE" in
  darwin*)
      export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
      alias ls='ls -G'
      alias ll='ls -l'
  ;;
  linux*)
    alias ls='ls --color'
    alias ll='ls -l'
  ;;
  dragonfly*|freebsd*|netbsd*|openbsd*)
    # ...
  ;;
esac
# <<< alias <<<

# >>> gvm >>>
export PATH=/usr/local/go/bin:$PATH
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
go env -w GOPROXY=https://goproxy.io,direct
# <<< gvm <<<


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fzf-dirs-widget() {
  # eval cd $(dirs -v | fzf --height 40% --reverse | cut -b3-)
  local dir=$(dirs -v | fzf --height ${FZF_TMUX_HEIGHT:-40%} --reverse | cut -b3-)
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  eval cd ${dir}
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}
zle     -N    fzf-dirs-widget

# Default ALT-X, For Mac OS: Option-X
if [[ `uname` == "Darwin" ]]; then
  bindkey '≈' fzf-dirs-widget
else
  bindkey '\ex' fzf-dirs-widget
fi


# >>> final >>>
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
        tmux attach -t default || tmux new -s default
fi

# >>> conda initialize >>>
export PATH="/Users/hugo/mambaforge/bin:$PATH"
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/hugo/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/hugo/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/Users/hugo/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/hugo/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

