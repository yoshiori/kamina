# Kamina

色々なフレームワークでローカルでファイル変更した時に自動的にブラウザリロードしてくれる仕組みがあったりなかったりで探して見つけて忘れてとか、探して見つからなくて絶望してとかに飽きたので汎用的に使えそうなものでっち上げた。
裏でこのサーバを立ちあげておくと、監視対象のファイルに更新があったらブラウザリロードする。


## 概要
ローカルのファイルを監視して変更があったら自動リロードします。
- chrome でしか動作確認してません。
- localhost で動くものにはだいたい対応してるはず


## 必要なもの
- node.js
- npm
- coffeescript
- port3002 を開けておく心意気

## インストール
    > git clone git@github.com:yoshiori/kamina.git
    > cd kamina/
    > npm install

## 使い方
`client/filecheck.user.js` を chrome にインストール

その後、

    > coffee app.coffee $target

`$target` に監視対象のファイルかディレクトリを指定します。
そのファイルかディレクトリ以下のファイルが更新されるとリロードされます。

