# チュートリアル

以下は対話的な環境で行う。
`PS> `は常にプロンプトのことを表しているとする。(実際の操作画面では、パスなども表示されていることがある)

## ヘルプを見る

```PowerShell
# man
PS> Get-Help Get-ChildItem
PS> Get-Help Get-ChildItem -Online

# man -k
PS> Get-Command *Item*
PS> Get-Command -Name *Item*

# with options
PS> Get-Command -Noun item*
PS> Get-Command -Noun item* -Verb get
```

もしローカルにヘルプを置いておきたいなら、管理者権限で以下を実行する
```PowerShell
PS> Update-Help -UICulture en-us -Force
```

## 変数の確認

```PowerShell
# ホームの確認
PS> $PSHOME

# バージョンの確認
PS> $PSVersionTable
```

## 基本的なコマンドの実行

```PowerShell
# cd する
PS> Set-Location C:\

# cd して push/pop する
PS> Push-Location D:\
PS> Pop-Location

# lsする
PS> Get-ChildItem
```

## パイプラインを使う

```PowerShell
<#
'C:\Program Files\Common Files\System' ディレクトリの中で、ファイルサイズのもっとも大きいファイルは何か?
#>
```

```PowerShell
<#
'C:\Program Files\Common Files\System' ディレクトリの中で、ファイルサイズが100KBより大きなものは何個あるか?
#>
```

```PowerShell
<#
環境変数の一覧を、変数名でソートして、 $HOME\env.txt に保存
#>
```

## 繰り返しを使う

```PowerShell
<#
現在実行されているプロセスについて、ID順にソートされた、
ID名,プロセス名
というCSV形式で出力する
#>
```

## 練習問題

```PowerShell
<#
Get-Alias コマンドでエイリアスの一覧が取得できる。
最も多く、エイリアスとして参照されているコマンドレットは何か
#>
```

