# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
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

zinit load zdharma/history-search-multi-word

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

# >>> theme >>>

autoload -U promptinit; promptinit

zstyle :prompt:pure:prompt:success color white
zstyle :prompt:pure:path color green
zstyle :prompt:pure:user color '#888888'
zstyle :prompt:pure:host color '#888888'
# <<< theme <<<

# >>> custom >>>
export PATH="$HOME/miniconda3/bin:$PATH"
# <<< custom <<<

# >>> alias >>>
case "$OSTYPE" in
  darwin*)
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
