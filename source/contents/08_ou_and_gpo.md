# OUとGPO
## OU (Organization Unit)について
ユーザー, グループやコンピュータなどのリソースをオブジェクトと呼ぶ。これらのリソースをまとめて管理するためのオブジェクトがOU。
このOUは、実際には、Active Directoryのオブジェクトを格納する構造体である、コンテナの一種。

コンテナの種類は、以下の通り。
1. OU
    - 管理者が自由に作成可能
    - グループポリシーをリンクできる
    - 下位にOUを作成して階層構造にできる
    - 特定のユーザ/グループに管理を委任できる
2. デフォルトのコンテナ
    - ユーザーでは作成できない
    - グループポリシーもリンクできない
    - 下位にOUを作成して階層構造することができない

デフォルト設定では、ユーザオブジェクトはUsersコンテナ、コンピュータオブジェクトはComputersコンテナに格納されるなどする。
できる限り、ユーザオブジェクト用OUなどを作成し、作成したOUに格納されるように設定を変更する方が柔軟な設計が可能になる。
ただし、ドメインコントローラだけは、**もともとの "Domain Controllers" OUから移動しない**ことが推奨。(Default Domain Controllers Policy というグループポリシーが適用済みのため。)

### OUの設計について
- 分けるべきもの
    - オブジェクトの種類: ユーザ/コンピュータ/グループ/サーバ...
    - 管理者がことなる部分
- 分けるべきでないもの
    - 変更が頻繁な(部門など)組織単位
        - 分社単位など、変更の少ない単位で分けるのはあり。この場合、各組織単位で分けた中で、一般的なOUを作成する

### PowerShell: OUの追加・削除

```Powershell
# OU追加
New-ADOrganizationalUnit -Name "01ユーザ" -Path "DC=org01,DC=itd-corp,DC=JP"

# OU削除
Remove-ADOrganizationalUnit -Identity "OU=01ユーザ,DC=org01,DC=itd-corp,DC=JP" -Confirm:$false

# デフォルトコンテナの変更
redirusr "OU=01ユーザ,DC=org01,DC=itd-corp,DC=JP"
redircmp "OU=03コンピュータ,DC=org01,DC=itd-corp,DC=JP"
```

## サービスアカウントの管理
サービスを実行するアカウントとして、独自に生成したユーザーで行う場合、アカウント管理が煩雑になりがち。
Windows Server 2008までには、MSA(Managed Service Account)という機能があり、パスワード更新の処理が自動化されていたが、複数のコンピュータでアカウントを共有できなかった。
Windows Server 2012から、**gMSA(group Managed Service Account)** という機能へ拡張され、サービスアカウントの認証を統一できるようになった。

### gMSAの展開手順

**TODO: 手順の追加**
1. KDSルートキー作成
2. gMSAの作成
3. gMSAのサービスへの割り当て

## グループポリシーとGPO(Group Policy Object)
### グループポリシー
ドメインに参加しているクライアントコンピューターの環境設定やセキュリティ設定を管理する機能。
### GPO
クライアントコンピューターに適用するポリシーをまとめたオブジェクト。
コンピューターごとに定義する**ローカルGPO**というものもあるが、以後単にGPOと言った場合には、Active DirectoryベースのGPOを指すことにする。

#### GPOの適用と継承関係
1. GPOはサイトやドメインなどのコンテナに割り当てる(これを*リンクする*という)
      - リンクされると、そのコンテナに属する全てのクライアントコンピューターやユーザーにGPOが適用される
2. GPOは継承される
      - あるコンテナにGPOをリンクすると、下位のコンテナにもGPOが適用される
      - あるコンテナに適用されるGPOは以下で決まる(継承関係ではよく見る普通のやつ)
          - 『継承ツリーの中で、自分より上位で、自分に最も近いGPO』

#### GPOの設定項目
GPOを設定するには、以下の2種類の機能を理解する必要がある。

1. ポリシー
    - 設定項目のこと
    - 基本設定よりも優先される
    - 新しいポリシーを作成する難易度が高いため、基本は用意されているポリシーを利用する
    - 以下の項目がある
        - ソフトウェアの設定
            - ソフトウェア配布を行うための設定
        - Windowsの設定
            - セキュリティ設定やログオン時のスクリプトなど
            - フォルダリダイレクトの設定もここ
        - 管理用テンプレート
            - レジストリベースのポリシー設定
            - 管理用テンプレートファイルを追加して項目を増やすことが可能
                - ADMタイプ  : GPOごとにファイルがコピーされるため、パフォーマンスに劣る
                - ADMXタイプ : Windows Server 2008で利用可能。普通はこちらを利用する。
                    1. セントラルストアを作成
                    2. デフォルトポリシーのコピー
                    3. ADMX管理テンプレートを以下に追加
                        - `%SystemRoot%SYSVOL\domain\Policies\PolicyDefinitions` 以下
                        - `%SystemRoot%SYSVOL\domain\Policies\PolicyDefinitions\ja-JP` 以下
2. 基本設定
    - Windows Server 2008より前のOSで利用するには、*グループポリシーの基本設定クライアント側拡張機能*という更新プログラムを適用する必要がある
    - 柔軟なグループポリシーを設定しやすい

#### GPOの更新方法
GPOはデフォルトでは、**クライアントコンピュータは90分に1回、ドメインコントローラは5分に1回**の頻度で更新される。
1. (クライアント側)手動更新
    ```PowerShell
    # 更新
    gpupdate /force
    # 更新状況確認
    gpupdate /R
    ```
2. リモートからの更新
    事前に、**スターターGPO**を使い、更新対象のコンピュータのWindows FWフィルタを設定しておく必要がある。(つまりこの作業は最初から行っておく)

#### GPOの運用
1. GPOは定期的にバックアップを取得しておく
2. GPOを変更する場合影響が非常に大きいため、*グループポリシーの結果機能*を利用するなどして、適用して問題ないことを確認する


# Windows Serverでのサービスのインストール

# クラスタリング

# 監視

# セキュリティ

# Windows 自動化について
## PowerShell
- 初心者用リソース
    - [Windows PowerShell Basics](https://technet.microsoft.com/ja-jp/library/dd347730.aspx)
    - [Windows PowerShell: スクリプト作成の短期集中講座](https://technet.microsoft.com/ja-jp/magazine/hh551144.aspx)
- 管理用の情報
    - [Windows Server 2012R2サーバーの管理性および自動化 - ホワイトペーパー](http://download.microsoft.com/download/A/8/B/A8BF66E5-B315-49D0-8EBE-02263B221DCC/Windows_Server_2012_R2_Server_Management_and_Automation_White_Paper.pdf)
    - [Windows Server 2012R2サーバーの管理性および自動化](http://download.microsoft.com/download/B/2/0/B20A660F-787F-4C17-8CE6-35E9789E2CB1/Windows-Server-2012-R2-Server-Management-and-Automation.pdf)
- コマンドリファレンス
    + [Windows and Windows Server Automation with Windows PowerShell](https://technet.microsoft.com/ja-jp/library/dn249523.aspx)
- Active Directory管理センターの、履歴ビューア機能

## AIK・sysprepについて
### できること/できないこと
### 使い方