# ネットワーク
## NICのチーミング
[Windows Server 2012 R2 NIC Teaming (LBFO) Deployment and Management](https://www.microsoft.com/en-us/download/details.aspx?id=40319) を参照のこと。

### 概要
- 同じ速度のNICを32個までメンバーにできる
- VLANに対応
- 一部利用できない機能もある
    + SR-IOV
    + DRMA
    + TCP Chimney
- スタンバイアダプタの設定ができる

### チーミングのモード
- Switch Independent Configuration
- Switch Dependent Configuration
    + Generic or Static Teaming/IEEE 802.3ad Draft v1
    + Dynamic Teaming/IEEE 802.1ax, LACP

### 負荷分散モード
- アドレスのハッシュ
- Hyper-Vポート
- 動的 (上記2つの組み合わせ)

## PowerShellでネットワーク設定
### IP/DNS
```PowerShell
New-NetIPAddress
  -InterfaceAlias <Interface Name>
  -IPAddress <IP Address>
  -PrefixLength <Prefix Length>
  -DefaultGateway <Default Gateway IP Address>

Set-DnsClientServerAddress
  -InterfaceAlias <Interface Name>
  -ServerAddress <DNS Server Address>
```

### NICチーミング
```PowerShell
Add-NetLbfoTeamNic <Team name> -VlanID <VLAN ID>
```

## ネットワーク設定確認系コマンド
- ipconfig
- ping
- route
- tracert

