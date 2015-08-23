# PowerShell 入門

触れないこと:
- class
- function, filter, script block
- module
- event

## 基本文法チュートリアル

### コマンド

改行 または ";" 区切りで記述される

```PowerShell
# コマンドレット, サービスの一覧を取得
Get-Command; Get-Service
# Windows PowerShell のイベントログのうち、Information のものを取得
Get-EventLog -LogName 'Windows PowerShell' -EntryType Information

# サブ式
## 変数に代入するなどで利用する
$(Get-ChildItem)

# スクリプトブロックの実行 : スコープが別スコープになる
## 変数に代入するなどで利用する
&{Get-Command}

# exe の実行
C:\Windows\System32\notepad.exe
# プログラムのパスにスペースが含まれている場合には、& を用いる
& 'C:\Program Files\Internet Explorer\iexplorer.exe' -k

# ps1 ファイルの実行
C:\foo.ps1
# ドットソース
. C:\foo.ps1
## もし実行ポリシーでのエラーがでる場合 (Windows Server 2012 R2 ではデフォルトで RemoteSigned のはず)
Set-ExecutionPolicy RemoteSigned
```

### Dynamic Invoke
また、マイナー機能として PowerShell Version 4から、Dynamic Invokeができる。
あまり使わないほうが良いと思う。

```PowerShell
$method = "GetType"
$HOME.$method()
```

### ワイルドカード

使える文字種は、`*, ?, []`。
```
# C:\Users\ 以下のPから始まるディレクトリを表示
Get-ChildItem C:\Users\p*
# aから始まる2文字の名前で拡張子 .txtのファイルを表示
Get-ChildItem a?.txt
# foo0.txt ~ foo9.txt を表示
Get-ChildItem foo[0-9].txt
# foo1.txt, foo4.txt を表示
Get-ChildItem foo[14].txt
```

逆に、ファイル名にこのような文字列を使っている場合 `-Path` パラメータで指定するとうまく動作しない。
エスケープするか、 `-LiteralPath`を使うと良い。

### コメント

```PowerShell
# 単一行のコメント

<#
複数行のコメント
を書く場合に利用する
#>
```

### 変数

PowerShell では宣言は必要なく、どんな型の値も代入できる。
変数は、`$variable_name` という形式か、 `${variable_name}`という形式。
型を指定して代入することもできるが、変換できない時にはエラーが出る。

```PowerShell
$foo = 1
# int 指定
[int]$foo = 1

# 以下はエラーが出る
# [int]$foo = "Not integer"

# PSドライブのアイテムは変数のようにアクセスできる
${Env:Path}
```

#### スコープ

変数のスコープは、3つある。
- global
    - どのスコープからでも読み書きできる
- private
    - 現在のスコープのみ読み書きできる
- script
    - 現在のスクリプト内のみ読み書きできる

```PowerShell
# globalスコープの例
$global:variable_name = 1
```

また、セッション間で変数を渡すには、`using:$variable_name` というように指定する

### 各種の型

変数は型を持っている。

```PowerShell
$a = 1

# 型を調べる
$a.GetType().FullName

# キャスト
## もし変換できない場合には、エラーになる
$b = [System.String]$a
## もし変換できない場合には、 $null になる
$b = $a -as [System.String]

# 型の比較
$a -is [System.String] #=> False
$a -isnot [System.String] #=> True
```

ちなみに、いくつかの型にはエイリアスが設定されている。
int型は、System.Int32型のエイリアスになっている。

#### 数値

```PowerShell
# 基本的な演算子 : 対応する複合代入演算子が存在する
1+2 #=> 3
1-2 #=> -1
1*2 #=> 3
1/2 #=> 0.5 ※整数の範囲で割り算したい場合には、%と組み合わせる
1%2 #=> 1

# ベキ乗 : .NET Framework の スタティックメソッドの利用
[math]::Pow(2, 10) #=> 1024

# 符号の反転
- $a

1 -lt 5
```

#### 文字列
文字列リテラルは、 `"` (ダブルクォート)または、`'`(シングルクォート)で囲んで表現される。
両者の違いは、Linuxのシェルと同様、変数展開の有無。

```PowerShell
$str="foo"
"${str}" #=> foo
'${str}' #=> ${str}
```

エスケープについては、\`(バッククォート)で行われる。
```PowerShell
$str="foo"
"`"${str}`"" #=> "foo"
```

さらに複数行の文字列を記述する際には、ヒアドキュメントが利用できる。
ヒアドキュメントは `@"..."@` または `@'...'@` という構文になる。
```PowerShell
$str=@"
Foo
Bar
"@
```

文字列の操作については、長さの取得、および結合/繰り返し/分割/... は以下の通り。
```PowerShell
# 長さ
"aaa".Length
# 結合
"aaa" + "bbb"
@("foo", "bar", "lol") -join ", "
# 繰り返し
"foo" * 10
# 分割
"foo, bar, lol" -split ", "
# 切り出し
"foobar".SubString(2, 4)
# 置換
"foobarlol" -replace "oo", "a"
```

次に正規表現によるマッチも可能。だけど、以下の方法だと $matchesは最初のマッチしか参照できない。
複数のマッチを参照したい場合には、 .NETのregexオブジェクトを利用する必要がある。
```PowerShell
# 簡易的なマッチ
"abcdefg" -match "b(.)(.)(?<last>.)" #=> True
$matches[0] #=> bced
$matches[1] #=> c
$matches["last"] #=> e

# 後方参照
"abcdefg" -replace "b(.)(.)(?<last>.)", "b`$2`$1"
```

#### 配列
`@(...)` で配列を作成できる。

```PowerShell
$a = @()
$a = 1, 2, 3, 4
$a = 1..4
$single = 1; $a = ,$single
$a = $(Get-ChildItem test*)
```

配列の各要素を取り出すには、何番目か指定する以外に、アンパック代入的な方法や、foreachを利用して取り出せる。
```PowerShell
$a = 1..10
$a[4]
# 4番目~7番目を取り出す(配列のインデックスは0から始まる)
$a[3..6]
$a[3..10-4]
# 最後の要素の取り出し
$a[-1]
# 4以下の要素のみ取り出す
$a -le 4
# 2以上4以下の要素のみ取り出す
$a -le 4 -ge 2

# 配列のメンバのメソッドを呼ぶ (暗黙的な foreach)
$str=@("a", "b", "c")
$str.ToUpper()
```

配列の操作は以下のようなものがある。
```PowerShell
$a = 1..10
$b = @(1, 4, 6)
# push
$a += 11
# 結合
$c = $a + $b

# 束縛演算子
$a -contains 5
5 -in $a
```

また、比較演算子を用いて、配列と文字列/数値などを比較した場合、Trueになる要素だけを返す。
```PowerShell
$a = 1..10
$a -gt 4
```

#### 連想配列
`@{key1=val1; key2=val2}` と作成する。
値の参照は、 `$hash.key` または `$hash["key"]` として参照する。

もし、どうしても順序を保った連想配列を作成したい場合は、`[ordered]@{key1=val1; key2=val2}` として作成する。

連想配列については、 `Add`や`Remove`のほか、 `Keys`, `Values`, `Contains` といった一般的なメソッドが利用できる。

### パイプラインとリダイレクト
パイプラインを使う用途として、オブジェクトの適当なプロパティだけを取り出したり、必要なオブジェクトだけにフィルタする、グループ化・ソートしたいといった目的がある。

```PowerShell
# プロパティでフィルタ
## プロセスのIDとプロセス名だけを表示
Get-Process | Select-Object id,Name | Format-List

# 必要なオブジェクトだけにフィルタ
## ファイルサイズが10KB以上のファイルのみを調べる
Get-ChildItem 'C:\Program Files\Common Files\System' | Where-Object {$_.Length -gt 10KB}

# コマンドの中でどのコマンドタイプが多いか調べる
Get-Command | Group-Object -Property CommandType
# その結果を少ない順に並べる
Get-Command | Group-Object -Property CommandType | Sort-Object -Property Count
Get-Command | Group-Object -Property CommandType | Sort-Object -Property Count | Select-Object -Last 1

# ForEach-Object の利用
## ForEach-Object 内では、パイプラインで渡されたオブジェクト1つずつが $_ に束縛される
Get-Process | ForEach-Object { Write-Host $_.ID }
```

次に、リダイレクトについては、Linuxと同様でも問題ないが、`Out-File`を使う方がおすすめ。
日本語環境でのWindowsのデフォルトエンコーディングは Shift-JISのため、単にリダイレクトすると面倒。

```PowerShell
# 単なるファイルの書き込み
Set-Content test.txt "foobar" -encoding UTF8

# リダイレクト
Get-Process | Out-File test.txt -encoding UTF8
```


### 比較演算子
- 一般的な比較
    - 大文字・小文字を区別しない : -eq, -ne, -gt, -ge, -lt, -le
    - 大文字・小文字を区別 : -ceq, -cne, -cgt, -cge, -clt, -cle
- 論理演算子
    - -and, -or, -xor, -not(!)
- ビット演算子
    - -band, -bor, -bxor, -bnot
    - -shr, -shl : ビットシフト演算子

### 制御構文

#### if ~ elseif ~ else

```PowerShell
if (cond) {
} elseif (cond) {
} else {
}
```
#### switch
割と複雑な構文。switchの引数に与えたオブジェクトは、switch内で `$_` で参照できる。

```PowerShell
switch [-regex|-wildcard|-exact|-casesensitive|-file](object) {
  val1 { ... ;break}
  val2 { ... ;break}
  {cond1} { ... ;break}
  {cond2} { ... ;break}
  default {...}
}
```

#### while/do

```PowerShell
while (cond) {
}
 
do {
} while (cond)
```

#### for

```PowerShell
for ($i = 0; $i -lt 100; $i++) {
}
```

#### foreach (ForEach-Object)

```PowerShell
foreach($process in Get-Process) {
  $process.Name
}
```

### エラー処理
以下の2つを分けて考える必要がある。
- PowerShellで発生したエラー
    - 存在しないコマンドを実行した場合など
- コマンドレットで発生したエラー
    - Get-Process -Name not-exist など、パラメータがおかしい場合など

PowerShellで発生したエラーを扱うための構文として、
```PowerShell
<# trap
trapは挙動が変わっていて、エラーが発生した行でtrapのブロック内が実行され、
trapブロック内でbreak していない場合には、元の箇所の次に戻って、引き続き処理が継続される。
#>
## すべてのエラーを trap
trap {
}
## 特定のエラーを trap
trap [System.IO.IOException]{
}

# 一般的な try catch
## catch でエラーの型を指定して catchできる
try {
} catch [System.Net.WebException], [...] {
} finally {
}
```
というものがある。

一方で、コマンドレットのエラーを処理するにはどうすれば良いか?
`-ErrorAction`, `-ErrorVariable` を利用するのが良いと思う。

```PowerShell
Get-Process -Name not_exist_process -ErrorAction SilentlyContinue -ErrorVariable variable
if ( $variable.Count -ne 0 ) {
  # もし、エラーが発生していたら
  ...
}
```

