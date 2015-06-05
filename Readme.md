labo-rank
====
情工の配属のために研究室の人気を調査するためのサイトを作るキット（雑）

## Usage
まず、config.coffeeを編集して上の方にあるYour Mongodb Url Hereと書いてある部分をMongodbのアドレスに置き換える。

#### heroku
とりあえずあげて見れるようにしたい場合はそのままherokuに上げる。herokuの詳しい使い方はググって。

mongodbはmongolabとかで適当に探してくるといい。
（2014年版はmongolabでやってた）

#### local
ローカルで動かすならnode.jsとCoffeeScriptをインストールして
```bash
$ npm install
```
で必要なものがインストールされる（はず）なので
```bash
$ coffee app.coffee
```
で起動できる。


## Edit
jsファイルを編集したい場合はpublic-coffee/以下のファイルを編集してCoffeeScriptからコンパイルする。

gulpfileがあるのでgulpをインストールして
```bash
$ gulp watch
```
としてからCoffeeScriptを編集すると.coffeeのファイルを保存するたびに自動的に対応する.jsに変換してくれるので楽。
