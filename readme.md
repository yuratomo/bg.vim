bg.vim
=======

Description
-----------
vimのバックグラウンドで、grepやmakeを実行するためのプラグインです。
grepは&grepprgで指定される外部grepを使用し、makeは&makeprgで指定されるコンパイラを使用します。
vimprocで非同期的に実行を行い、その結果を定期的(au CursorHold)に取得して、QuickFixに追加するように動作します。
バックグランド実行中は一時的にupdatetimeを変更しますが、実行完了後に元に戻します。
そのため、updatetimeに依存するほかのスクリプトと競合する可能性があります。
また、バックグランド動作中に別のバックグラウンド処理を行うと、以前のバックグランド動作はキャンセルされます。
QuickFixのウィンドウでカーソルが最後の行にある場合、自働スクロールします。
バックグラウンド動作中にQuickFixからジャンプすることも可能です。

Requirements
------------
このスクリプトは、vimprocを必要とします。
vimprocをインストールしてください。

Usage
-----

### grep ###
    :Background grep [grep-args]

### make ###
    :Background make [grep-args]

### cancel ###
    :Background cancel


HISTORY
-------

### v0.2.0 by yuratomo ###
* Support make.
* Change command name. (BG to Background)

### v0.1.0 by yuratomo ###
* first version.
