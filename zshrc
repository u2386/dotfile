# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hugo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# >>> zplug >>>
source ~/.zplug/init.zsh

zplug "junegunn/fzf-bin", \
       	from:gh-r, \
       	as:command, \
       	rename-to:fzf, \
       	use:"*darwin*amd64*"
zplug "plugins/z", \
	from:oh-my-zsh
zplug "plugins/kubectl", \
	from:oh-my-zsh
zplug mafredri/zsh-async, \
       	from:github
zplug "sindresorhus/pure", \
	use:pure.zsh, \
       	from:github, \
       	as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
# <<< zplug <<<

# >>> theme >>>
# .zshrc
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
alias ls='ls --color'
alias ll='ls -l'
# <<< alias <<<

# >>> gvm >>>
export PATH=/usr/local/go/bin:$PATH
[[ -s "/home/hugo/.gvm/scripts/gvm" ]] && source "/home/hugo/.gvm/scripts/gvm"
go env -w GOPROXY=https://goproxy.io,direct
# <<< gvm <<<

