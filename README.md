# README

* アプリケーション名
MyAppArticle

* アプリケーション概要
ユーザー登録後に記事投稿ができる
投稿した記事はトップページに表示される
投稿した記事には閲覧した他ユーザーが共感した時に評価を残すことができる

* 目指した課題解決
日々時間に追われる多忙な方が、少しでも時間を作れる様な
時短術や日常における生産性向上に繋がる知見を共有し合うことで
利用した方が豊かな生活を送れるための一助になれればと思い

* 洗い出した要件
ユーザー管理機能
記事投稿機能
記事検索機能
フォロー機能
お気に入り機能
記事評価機能

* データベース設計
## articles テーブル

| Column   | Type    | Options     |
| -------- | ------- | ----------- |
| title    | string  | null: false |
| text     | text    | null: false |
| genre_id | integer | null: false |

### Association

- belongs_to :genre
- belongs_to :user
- has_many   :comments
- has_many   :article_tag_relations
- has_many   :favorites

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association

- has_many :articles
- has_many :comments
- has_many :favorites, dependent: :destroy
- has_many :relationships
