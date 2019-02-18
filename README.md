# L4S WebS コース 課題プロダクト設計

author: こなつ

## コピーするサイト

https://lfs5-kadai.herokuapp.com/

## 機能

- 新規登録
- ログイン
- ログアウト
- 検索
- 検索結果へのコメント&投稿
- 投稿の一覧表示
- ユーザ情報の表示

## DB 設計

### User

| カラム名        | 型       | 説明                 |
| --------------- | -------- | -------------------- |
| id              | integer  | ユーザ ID            |
| name            | string   | ユーザ名             |
| password_digest | string   | パスワード           |
| image_url       | string   | ユーザアイコンの URL |
| created_at      | datetime | 作成された時刻       |
| updated_at      | datetime | 更新された時刻       |

has_many :posts

### Post

| カラム名   | 型         | 説明                           |
| ---------- | ---------- | ------------------------------ |
| id         | integer    | ID                             |
| comment    | string     | 投稿したユーザがつけたコメント |
| artist     | string     | アーティスト名                 |
| album      | string     | アルバム名                     |
| track      | string     | トラック名                     |
| image_url  | string     | アルバムの画像の URL           |
| music_url  | string     | サンプル音声の URL             |
| created_at | datetime   | 作成された時刻                 |
| updated_at | datetime   | 更新された時刻                 |
| user       | references | 投稿したユーザ                 |

belongs_to :user

## URI 設計

| action | path              | 説明                                      |
| ------ | ----------------- | ----------------------------------------- |
| get    | /                 | 全ユーザの投稿を表示                      |
| get    | /sign_up          | 新規登録画面を表示                        |
| get    | /search           | 検索ページを表示                          |
| get    | /home             | ユーザページを表示                        |
| get    | /edit/:id         | Post 編集ページの表示                     |
| get    | /signout          | ログアウト処理をし`/`へリダイレクトする   |
| post   | /signin           | ログイン処理し`/search`へリダイレクトする |
| post   | /sign_up          | 新規登録処理をする                        |
| post   | /search           | 検索し結果を表示する                      |
| post   | /posts/new        | Post の投稿                               |
| post   | /posts/:id/update | Post の更新                               |
| post   | /posts/:id/delete | Post の削除                               |

## View 設計

| path      | 概要            | できること                               |
| --------- | --------------- | ---------------------------------------- |
| /         | top ページ      | (未認証時)ログイン、全ユーザの投稿を表示 |
| /sign_up  | 新規登録画面    | 新規登録                                 |
| /search   | 検索ページ      | 検索、検索結果の表示、その場でのコメント |
| /home     | ユーザページ    | ユーザの投稿を表示                       |
| /edit/:id | Post 編集ページ | 指定した Post のコメントを編集する       |
