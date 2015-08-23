# PowerShell の概要

## 資料
- 初心者用リソース
    - [Windows PowerShell Basics](https://technet.microsoft.com/ja-jp/library/dd347730.aspx)
    - [Windows PowerShell: スクリプト作成の短期集中講座](https://technet.microsoft.com/ja-jp/magazine/hh551144.aspx)
- 管理用の情報
    - [Windows Server 2012R2サーバーの管理性および自動化 - ホワイトペーパー](http://download.microsoft.com/download/A/8/B/A8BF66E5-B315-49D0-8EBE-02263B221DCC/Windows_Server_2012_R2_Server_Management_and_Automation_White_Paper.pdf)
    - [Windows Server 2012R2サーバーの管理性および自動化](http://download.microsoft.com/download/B/2/0/B20A660F-787F-4C17-8CE6-35E9789E2CB1/Windows-Server-2012-R2-Server-Management-and-Automation.pdf)
- コマンドリファレンス
    + [Windows and Windows Server Automation with Windows PowerShell](https://technet.microsoft.com/ja-jp/library/dn249523.aspx)
- Active Directory管理センターの、履歴ビューア機能

## PowerShell の概論

Windowsのシェル実行環境のこと。

### 特徴

PowerShellの特徴として、以下のようなものがある。
1. コマンド形式は、 {動詞}-{名詞} の形式
2. 各コマンドは、 .NET Framework のオブジェクトを出力する
    - 実際には、少し拡張されている。PowerShellのディレクトリの types.ps1.xml にある
3. WindRMなどの管理系ツールとの連携がある
    - PowerShell DSC(Desired State Configuration) と呼ばれる宣言的な管理フレームワークがWindows onlyな環境では便利に見える

### 現状

| OS Version          | Default .NET Framework | Default PowerShell |
|---------------------|------------------------|--------------------|
| 2008 R2             | 2.0                    | 2.0                |
| 7 SP1               | 3.5SP1                 | 2.0                |
| 2012                | 4.5                    | 3.0                |
| 8                   | 4.5                    | 3.0                |
| 2012 R2             | 4.5                    | 4.0                |
| 8.1                 | 4.5                    | 4.0                |
| 10(Tech prevで確認) | 4.5                    | 5.0                |
| 2016?               | ?                      | ?                  |

### PowerShell 5.0での新機能

[What's New in Windows PowerShell](https://technet.microsoft.com/en-us/library/hh857339.aspx#BKMK_new50) (英語が嫌な人は、 [わんくま同盟大阪勉強会#62「PowerShell 5.0 新機能」資料公開](http://winscript.jp/powershell/292) くらいを見る。現状他に日本語資料がなさそう)

個人的な注目ポイントは、
- `ConvertFrom-String`
- デバッグ系の充実
- PowerShell ISE を利用したリモートのファイル編集

