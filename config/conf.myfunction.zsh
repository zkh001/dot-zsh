
## ZSH関係のコマンド

# zshのmanから検索してくれるやつ
function zman() {
    PAGER="less -g -s '+/^       "$1"'" man zshall
}

# zshを再起動する
function zreload() {
    exec $SHELL
}


## 一般コマンド

# いろいろな拡張子のファイルを解凍するコマンド
function extract () {
    if [ -f $1 ] ; then
        case $1 in
						*.tar.bz2) tar xvjf $1	 ;;
						*.tar.gz)	 tar xvzf $1	 ;;
						*.tar.xz)	 tar xvJf $1	 ;;
						*.bz2)		 bunzip2 $1		 ;;
						*.rar)		 unrar x $1		 ;;
						*.gz)			 gunzip $1		 ;;
						*.tar)		 tar xvf $1		 ;;
						*.tbz2)		 tar xvjf $1	 ;;
						*.tgz)		 tar xvzf $1	 ;;
						*.zip)		 unzip $1			 ;;
						*.Z)			 uncompress $1 ;;
						*.7z)			 7zr x $1			 ;;
						*.lzma)		 lzma -dv $1	 ;;
						*.xz)			 xz -dv $1		 ;;
            *)         echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function findgrep() {
    if [[ $# -lt 3 ]]; then
        cat <<EOF
Short of arguments!!
Usege: arg1 -> search path
       arg2 -> file name
       arg3 -> search word
EOF
        return 0
    fi
    find $1 -name $2 -exec grep $3 {} +
}

# cshのsetenvをzshでも
function setenv() { export $1=$2 }

# エイリアスコマンドのオリジナルコマンドを表示
function resolve_alias() {
    local cmd="$1"
    while \
        whence "$cmd" >/dev/null 2>/dev/null \
            && [ "$(whence "$cmd")" != "$cmd" ]
    do
        cmd=$(whence "$cmd")
    done
    echo "$cmd"
}

# ヒットするやつを削除するやつ
function findrm() {
    if [ $# -lt 2 ]; then
        cat <<EOF
Short of arguments!!
Usage: findrm NamePattern DistDir
EOF
        return 0
    fi
    if [ $2 = "" ]; then
        # current dir
        find . -name "$1" -exec rm {} ";"
        return 1
    fi
    find $2 -name "$1" -exec rm {} ";"
}

# 1つ上のディレクトリに移動する
function cdup() {
    echo
    cd ..
    zle reset-prompt
}; zle -N cdup


# PATHをスペースで分割したものを掃き出す
function get_split_path(){
    # sed -e 's/:/ /g' => 文字列中の':'を' 'で置換
    echo $PATH | sed -e 's/:/ /g'
}

# カレントディレクトリの一覧をリストで取得する
function get_current_directories() {
    echo `ls -al | awk '$1 ~ /^d/ {print $9}'`
}

# emacsが起動してるかどうか
function is_emacs() {
    [[ "$EMACS" != "" ]]
}

# emacs上のシェルが起動してるかどうか
function is_eterm(){
    [[ "$TERM" = "eterm-color" ]]
}

# screenが起動してるかどうか
function is_screen_running() {
    # tscreen also uses this varariable.
    [ ! -z "$WINDOW" ]
}

# tmuxが起動してるかどうか
function is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}

# コマンドが存在するかをチェック
function is_exist_cmd () {
    [[ ${+commands[$1]} = 1 ]]
}

# ファイルが存在するかをチェック
function is_exist_file () {
    [[ -f $1 ]]
}

# 複数のキーマップにまとめてキーバインドを設定する関数
# $1  --> bind-key
# $2  --> command
# $3~ --> keymaps
function reg-key () {
    if [ $# -eq 2 ]; then
        bindkey $1 $2
        return 1
    elif [ $# -lt 2 ]; then
        echo "Usage: key_register KEY CMD KEYMAP(1) [ ... KEYMAP(n)]"
        return 0
    fi
    for kmap in "$@" ;do
        if [ "$kmap" != "$1" -a "$kmap" != "$2" ]; then
            bindkey -M "$kmap" "$1" "$2"
        fi
    done
    return 1
}

# 引数に渡した文字列をコマンドラインに展開する関数
# ただし，適当な関数を介さないといけない欠点がある?
# usage : てきとうなコマンドを定義しておく
# 例:----------------------------------------
# function insert_git() { insert_cmd_in_line "git"; }
# zle -N insert_git
# bindkey "^P" insert_git
# ------------------------------------------
# これを適当なキーに割り当て，それを実行すると...
# $ git[space]■
function insert_cmd_in_line () {
    if [ $# = 0 ]; then
        echo "Usage: cmdins 'CMD and OPTIONs'"
        return 0
    fi
    BUFFER="$1 "
    CURSOR=$#BUFFER
}

# 前景色のサンプルを表示する関数
function disp-color-list-FG() {
    local nn
    for nn in {016..255}
    do
        echo -n "\e[0;38;5;${nn}m${nn}\e[m"
        [ `expr ${nn} % 8` -eq 7 ] && echo "" || echo -n " "
    done
    echo ""
}

# 背景色のサンプルを表示する関数
function disp-color-list-BG() {
    local nn
    for nn in {016..255}
    do
        echo -n "\e[0;48;5;${nn}m${nn}\e[m"
        [ `expr ${nn} % 8` -eq 7 ] && echo "" || echo -n " "
    done
    echo ""
}

