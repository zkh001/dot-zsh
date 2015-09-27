
##########################################
###     zshの環境設定をここで記述する      ###
##########################################

export LANG=ja_JP.UTF-8

LISTMAX=9999


#################
####  path   ####
#################

## 存在しないパスを登録しない
#       N: NULL_GLOBオプションを設定。
#          globがマッチしなかったり存在しないパスを無視する。
#       -: シンボリックリンク先のパスを評価。
#       /: ディレクトリのみ残す。
path=(
    # System
    /bin(N-/)
    /sbin(N-/)
    /usr/bin(N-/)
    /usr/sbin(N-/)
    /usr/games(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $HOME/local/bin(N-/)
    $HOME/local/sbin(N-/)

    $HOME/.cabal/bin(N-/)

    # Mac用
    /opt/local/bin(N-/)
    /usr/sfw/bin(N-/)

    # windows用(cygwin,meadow)
    /cygdrive/c/meadow/bin(N-/)

    $HOME/.anyenv/bin(N-/)

    # for ruby
    # /var/lib/gems/*/bin(N-/)
    #$HOME/.rbenv/bin(N-/)

    )

## for ruby

# rbenv
# git clone https://github.com/sstephenson/rbenv
# git clone https://github.com/sstephenson/ruby-build.git path/to/rbenv/plugins/ruby-buildif
# (( ${+commands[rbenv]} )) && eval "$(rbenv init -)"

# anyenv (multi env manager ,rbenv, pyenv, ..etc)
# git clone https://github.com/riywo/anyenv ~/.anyenv
(( ${+commands[anyenv]} )) && eval "$(anyenv init -)"
