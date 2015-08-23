# 実践に役立つ雑多な項目

## リモート実行

## ワークフロー

## バックグラウンド実行

## PSドライブ
PowerShellから階層構造を持つリソースに、簡単にアクセスするためのもの。
例えば、ファイルシステムや、レジストリ、環境変数、関数、スクリプト変数など。

```
# PSドライブの確認
Get-PSDrive

# PSドライブへの移動 と 参照
Set-Location hkcu:
Get-ChildItem
```

注意点として、環境変数を変更するために、envを直接書き換えても、システム全体では反映されない。
Environmentクラスの `SetEnvironmentVariable`メソッドを利用すること。

## パラメータ

### 共通パラメータ
以下のパラメータは、ヘルプ上でも `<CommonParameters>` となっている。
`Get-Help about_CommonParameters` を見ると、さらに詳細がわかる。

- -Verbose
    - 詳細なログを表示
- -Debug
    - もっと詳細なログを表示
- -WarningAction _action_
    - 実行時に warning が発生した場合の処理を指定する
    - _action_ の内容
        - Continue
        - Stop
        - SilentlyContinue
        - Inquire
        - Ignore
- -ErrorAction _action_
    - 実行時に error が発生した場合の処理を指定する
    - _action_ の内容は WarningAction と同じ
- -WarningVariable _variable_
    - 指定された文字列変数に、warningを格納する
    - _variable_ の指定方法は、
        - variable_name の場合、${variable_name} に格納される
        - +variable_name の場合、${variable_name} に追加される
- -ErrorVariable _variable_
    - 指定された文字列変数に、errorを格納する
    - _variable_ の指定方法は、WarningVariable と同じ
- -OutVariable _variable_
    - 指定された文字列変数に、出力を格納する
    - _variable_ の指定方法は、WarningVariable と同じ
- -OutBuffer <Int32>
    - 指定された数+1 のオブジェクトが生成されてから、パイプラインにある次のコマンドレットを実行
- -?
    - ヘルプを表示

リスク管理パラメータと呼ばれる、破壊的な変更を行うコマンドによく使われるパラメータがある。
- -WhatIf
- -Confirm

### デフォルトパラメータ
コマンドを実行する際、パラメータを毎回指定するのが面倒な場合などに、パラメータを省略した時のデフォルトをユーザー側で定義できる。
`$PSDefaultParamaterValues` 変数に、連想配列として定義していく。

```
<#
  $psdefaultparamatervalues = @{"_コマンドレット名_:_パラメータ名_"=_デフォルトパラメータ_}
  コマンドレット名や、パラメータ名には、ワイルドカードを利用できる
  また、一時的に無視したい場合には、
  $psdefaultparamatervalues["Disabled"] = $tue
  とすれば良い。
#>

# New-Item の ItemType をディレクトリにする
$PSDefaultParamaterValues = @{"New-Item:ItemType"="Directory"}
```

## 暗黙的な変数
以下にいくつか、便利な自動変数を列挙した。
これ以外にも様々な自動変数がある。
詳細は、 `about_Automatic_Variables` を参照のこと。

- $\_ ($PSItem)
    - 現在のパイプラインオブジェクト
- $Input
    - パイプラインに入力されたオブジェクト
- $Args
    - 関数に渡されるパラメータの配列
- $Switch, $foreach
    - それぞれ、現在処理されているオブジェクト
    - current プロパティにアクセスすれば良い
- $Matches
    - -match 演算子利用時に、マッチ情報が含まれた連想配列

## .NET Framework の利用

### クラスのインスタンスを作成する
普段扱っているPowerShellのオブジェクトは、もともと .NET Frameworkのものだが、
もっと複雑なことをしたい場合に、直接クラスのインスタンスを作成することがある。

```PowerShell
$wc = New-Object System.Net.WebClient
$wc.DownloadString("http://www.atmarkit.co.jp/") > atmarkit.html
```

### 静的メソッドの呼び出し

`[クラス名]::func`でアクセスできる。

```PowerShell
[math]::Pow(2, 4)
```

## PowerShell バージョンを指定する

例えば、バージョン 3.0以降でのみ実行を許したい場合、スクリプト戦闘で、以下のように記載すれば良い。
```PowerShell
requires -Version 3.0
```
