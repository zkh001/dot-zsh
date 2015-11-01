##########################
###   Prompt Setting   ###
##########################

# # プロンプトの設定テーマを使う
# # ちなみにテーマのプレビューは
# # prompt -l して prompt -p テーマ名 でやる
# # Set up the prompt
# autoload -Uz promptinit
# promptinit
# prompt adam1


# 手動で設定する

# ***memo***
# colorsでやる!
# $fg[色]や$fg_bold[色]や$fg_no_bold[色]や$bg[色]や$bg_bold[色]や$bg_no_bold[色],それと ${reset_color} を駆使する
# ちなみに%{ ... %} で囲うほうがよい

# 具体的なやり方
#     ${fg[色]} ここの文字列に色が付く ${reset_color} これ以降はデフォルトの色に戻されれる

# available colors list :
#   black  white  red     blue
#   green  blue   yellow  magenta

# 特殊文字(括弧内は表示フォーマットとかです)
# %# : user type( normal -> %, root -> #)
# %y : loggined terminal (%l also)
# %~ : current dir (~/CURRENT-DIR)
# %c : current dir (CURRENT-DIR without '~', if PWD is HOME -> ~)
# %C : current dir (CURRENT-DIR without '~')
# %d : current working dir (optional, %INTEGERd, e.g. %-1d)
# %h : number of history
# %j : number of jobs
# %n : user name
# %m : host name
# %M : host name (with domain)
# %? : last command result
# %_ : the status of parser( shell command, e.g. if , for )
#
# %B ... %b: start/stop boldface mode
# %U ... %u: start/stop underline mode
# %S ... %s: start/stop standout mode
# %E : clear to end of line

# %t : time (hh:mm) (24th)
# %T : time (hh:mm) (with am/pm)
# %* : time (hh:mm:ss)
# %D{...} : date (yy-mm-dd)
# %w : date (DAY dd)
# %W : date (mm/dd/yy)

local verbose_prompt=0


if [ $verbose_prompt = 0 ]; then
    # 通常
    PROMPT="%{$fg_bold[cyan]%}%n%#%{$reset_color%} "
    # 右側に表示させたい
    RPROMPT="%{$fg_bold[green]%}[%~]%{$reset_color%}"
    # コマンドが2行以上の時に表示されるプロンプト
    PROMPT2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
else
    # 別バージョン(2行に渡っていろいろ表示するやつ)
    #     [ ... ]
    #     $ ■

    # gitとか用
    autoload -Uz vcs_info
    setopt prompt_subst

    # 通常
    PROMPT="%{$fg_bold[cyan]%}<%n/%M :%T> [%~]
%#%{$reset_color%} "
    PROMPT2="%{$fg_bold[cyan]%}<%n/%M :%T> [%~]
%_>%{$reset_color%} "
fi
