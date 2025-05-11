# 日めくりカウントダウンアプリ

## 概要

登録したイベントの発生日までの日数を「日めくりカレンダー」風に表示するWebアプリケーションです。  
OAuth2による認証機能を備え、フロントエンドにはTailwind CSSを利用しています。

## 主な機能

- イベントの登録／編集／削除  
- 登録したイベントの発生日までの残り日数を自動計算  
- 各イベントへのコメント投稿  
- OAuth2認証（oauth2 gem ＋ Spring Authorization Server）  
- レスポンシブ対応のシンプルなUI（tailwindcss-rails gem）

## 技術スタック

- **言語／フレームワーク**: Ruby 3.x, Ruby on Rails 8.0.1  
- **認証サーバ**: Spring Authorization Server（Java）  
- **認証クライアント**: oauth2 gem  
- **フロントエンド**: tailwindcss-rails gem  
- **データベース**: SQLite3（開発）, MySQL（本番）  
- **Webサーバ**: Puma  
- **プロダクション環境**: Raspberry Pi 5, nginx  
- **モニタリング**: Prometheus, Grafana

## 開発環境構築

### 前提条件

- Ruby 3.x  
- Node.js, Yarn  
- bundler  
- SQLite3（または開発用MySQL）

### セットアップ手順

```bash
git clone <リポジトリURL>
cd <リポジトリ名>

# Ruby Gem のインストール
bundle install

# JavaScriptパッケージのインストール
yarn install

# Rails Credentials にOAuthクライアント情報を設定
rails credentials:edit
# 以下を追加例
# oauth:
#   client_id:     "YOUR_CLIENT_ID"
#   client_secret: "YOUR_CLIENT_SECRET"

# データベース準備
rails db:create db:migrate

# サーバ起動（ポート3001）
bin/rails server -p 3001
