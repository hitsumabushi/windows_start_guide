# PowerShell 入門

## PowerShell を実行する方法

- PowerShell.exe で対話的に実行
- エディタで .ps1 ファイルを書き、 `PowerShell.exe -File {実行したいファイルのパス}`
- PowerShell ISE で開発/実行

## PowerShell で実行できるファイルの種類

## Execution-Policy の設定

# PowerShell の使い方

触れないこと:
- function, filter, script block
- module
- event

## 基本文法

### 型

### パイプ

### 代入, 比較演算子

### if, for, while,...

### エラー処理

## 実践に役立つ雑多な項目

### リモート実行

### ワークフロー

### バックグラウンド実行

### PSドライブ

### パラメータ

#### 共通パラメータ

#### デフォルトパラメータ

### 変数

#### 暗黙的な変数

#### 共通変数

### .NET Framework の利用

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

## パラメータを使う

### スプラッティング

## パイプを使う

## 繰り返しを使う

