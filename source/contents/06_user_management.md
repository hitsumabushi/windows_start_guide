# ユーザー管理/グループ管理
## 認証設定
設定できる項目としては、
1. ユーザーによるパスワード変更可否
2. パスワードの有効期間
3. アカウントを無効にする
4. ロックアウトポリシー
    - Administrator はロックアウトできないため、パスワードの管理/変更に注意する

## ユーザーの権限設定
権限を付与するには、権限が付与されているグループにメンバーとして追加するか、ローカルセキュリティポリシーに登録する。

## Powershell
### ローカルユーザーの作成・削除
```Powershell
NET USER <Username> /add /fullname:<full name> /comment:<comment>
NET USER <Username> /delete
```
### ローカルグループの作成・削除
```Powershell
NET LOCALGROUP /add <Group Name> /comment:<comment>
NET LOCALGROUP /delete <Group Name>
```

