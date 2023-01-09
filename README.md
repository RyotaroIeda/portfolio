# Sauna&Camp

サウナ・テントサウナ・自然でテントサウナができるおすすめスポットをシェアするアプリです。


![スクリーンショット 2023-01-09 16 44 18](https://user-images.githubusercontent.com/109324447/211260669-5d685c02-0234-42f5-84b8-d08b54841762.png)

![スクリーンショット 2023-01-09 15 21 42](https://user-images.githubusercontent.com/109324447/211256052-39be43f4-cb20-46e6-b9b6-affcaefbe293.png)


## URL

[まだデプロイしていないため後で記載]()

ゲストログインボタンから、メールアドレスとパスワードを入力せずにログインできます。

## 使用技術

- Ruby 3.0.2
- Ruby on Rails 6.1.7
- MySQL 5.7
- Heroku
- AWS
    - S3
- Docker/Docker-compose
- RSpec
- rubocop
- Google Maps API


## 機能一覧

- アカウント作成、ログイン、ログアウト機能(devise)
- ゲストログイン機能
- プロフィール編集機能(ゲストログインの場合は除く)
- 投稿作成機能
    - 画像投稿(refile)
    - サウナを非公開に設定すると他のユーザから見れなくなる
    - 位置情報検索機能(geocoder)
- 投稿削除機能
- 投稿編集機能
- 投稿並べ替え機能（新しい順、古い順、名前順）
- マップ機能
    - 投稿の位置情報を元にマップにマーカー表示
- 口コミ機能
- お気に入り機能
    - ユーザーがお気に入りしたサウナは一覧表示可能
- ランキング機能
    - お気に入り数に応じてトップページに人気サウナランキングが表示
- ページネーション機能(kaminari)
- 検索機能(ransack)
- Twitter・Facebookシェア機能


## テスト

- request spec
- model spec
- helper spec


