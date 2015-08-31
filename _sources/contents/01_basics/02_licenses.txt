# ライセンス

## 資料
### 全般
- [ライセンス まるごと 早わかりガイド](http://download.microsoft.com/download/A/2/8/A28985D6-78DE-41A4-B5EA-6FA0270D824B/LicenseQuickStartGuide.pdf)
- 通常の利用
    - [コア ライセンスの概要と基本的な定義 - マイクロソフト ボリューム ライセンス ガイド](https://www.microsoft.com/ja-jp/licensing/about-licensing/briefs/licensing-by-cores.aspx)
    - [仮想環境で使用する Microsoft サーバー製品のライセンス - マイクロソフト ボリューム ライセンス ガイド](https://www.microsoft.com/ja-jp/licensing/about-licensing/briefs/virtual-licensing.aspx)
- 事業者向け
    - [SPLA の基礎知識 | マイクロソフト サーバー & クラウド プラットフォーム](http://www.microsoft.com/ja-jp/server-cloud/windows-server/licenseguide/spla-01.aspx)
    - [Microsoft Services Provider License Agreement - マイクロソフト ボリューム ライセンス](https://www.microsoft.com/ja-jp/licensing/licensing-options/spla-program.aspx#tab=1)

### 各ライセンス
- Windows Server のライセンス
    - [Windows Server 2012 Datacenter / Standard ライセンス早わかりガイド | マイクロソフト サーバー & クラウド プラットフォーム](https://www.microsoft.com/ja-jp/server-cloud/windows-server/licenseguide/default.aspx)
- SQL Server のライセンス
    - [SQL Server 2014 ライセンス データシート](http://download.microsoft.com/download/c/b/0/cb0931b5-5b44-4a6a-afb7-befb81ae409f/SQL_Server_2014_Licensing_Datasheet-JP.PDF)


## よく検討されるライセンス
- サーバーライセンス
- CAL (Client Access License)
- RDS CAL(Remote Desktop Service CAL)
- VDA (Virtual Desktop Access) サブスクリプション
- RMS CAL(Rights Management Service CAL)

## Windows のライセンス体系
Windows のライセンス体系でもっとも重要なことは、ソフトウェア自体のライセンスの他に、ユーザーアクセスについてのライセンス(CAL)の存在を理解すること。

![License](https://docs.google.com/drawings/d/13Sdf0sIJQGXq70UdHOT0KYw2drl4Em7ZvgeKPNPfw40/pub?w=771&h=430)

### サーバーライセンス

### CAL
管理目的以外で接続するユーザーがいる場合に必要。
(管理目的用には、最初から2接続張れる)
![User License Types](https://docs.google.com/drawings/d/1ty_4JHZl5b1KLvRt_lnO56Ca_JyfHUcErcCEt1-tcbs/pub?w=960&h=720)
1. CALの種類
    - ユーザーCAL
    - デバイスCAL
2. CALの割り当て方式
    - ユーザー・デバイスごとの割り当て
        + それぞれ、ユーザー数 or デバイス数で管理
    - サーバーインスタンスごとの割り当て
        + サーバーインスタンスの、最大同時接続数(ユーザー or デバイス)で管理

上記の通り、CALの種類と割り当て方式の組み合わせで4通りある。
なにで管理したいかによって、割り当て方式と種類が変わるため、注意して選択する必要が有る。
またCALはダウングレードできるので、古いOSでも利用可能。

機能ごとのCALもあるが、基本的なモデルは同様のものになっている。

## ライセンスの買い方
### SPLA
SPLAの特徴は...
1. 1ヶ月単位の従量課金のライセンス
    - 翌月発注
2. エンドユーザーにサービスプロバイダが、サービスとしてMSのソフトウェアを提供できる
3. 複数のライセンス形態
    - 利用するソフトウェアごとに、選択できるライセンス形態は決まっている
4. SPLAと他のライセンスを混ぜることは基本的に"難しい"


## ライセンスの認証方法

1. マルチライセンス認証キー(MAK)ライセンス認証
    + インスタンスごとに入力する
2. KMSライセンス認証
    + KMSを立てキーを登録しておき、DNSのSRVレコードに登録しておくと、ライセンス認証してくれる
    + 認証される側が一定台数ないと認証されない
    + Windows 7などが混在している場合でも使える
3. ADによるライセンス認証
    + ADに参加していると利用可能
    + Windows 7以前のコンピューターでは利用不可


