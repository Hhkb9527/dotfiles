LANG="en_US.UTF-8"
LANGUAGE="en_US.UTF-8"
export PATH="$PATH:/home/hero/.local/bin/"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export LESSCHARSET=utf-8 # 解决git log的中文乱码
export TERM=xterm-256color

alias ll="ls -lh"
alias lla="ls -lah"
alias ghel="vim ~/.zsh/plugin/git.zsh"
alias gpom="git push origin master"

# tencent proxy
export http_proxy=http://web-proxy.tencent.com:8080/
export https_proxy=https://web-proxy.tencent.com:8080/

bindkey "," autosuggest-accept

source ~/.zsh/plugin/git.zsh
source ~/.zsh/plugin/commacd.zsh
source ~/.zsh/plugin/zsh-autosuggestions.zsh
source ~/.zsh/plugin/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/plugin/autopair.zsh && autopair-init
