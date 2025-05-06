class SessionsController < ApplicationController
  # 認証前提フィルタをスキップ
  skip_before_action :require_login, only: [ :new, :callback, :failure, :destroy ]

  CLIENT = OAuth2::Client.new(
    Rails.application.credentials[:oauth][:client_id],
    Rails.application.credentials[:oauth][:client_secret],
    site: "http://localhost:9000",
    authorize_url: "/oauth2/authorize",
    token_url: "/oauth2/token"
  )

  def new
    auth_url = CLIENT.auth_code.authorize_url(
      redirect_uri: callback_url,
      scope: "openid profile email",
    )
    redirect_to auth_url, allow_other_host: true
  end

  # 認可コード受け取り＆アクセストークン取得
  def callback
    token = CLIENT.auth_code.get_token(
      params[:code],
      redirect_uri: callback_url
    )
    # 必要に応じて UserInfo エンドポイントを叩く
    user_info = token.get("/userinfo").parsed

    session[:current_user] = {
      uid:   user_info["sub"],
      name:  user_info["name"],
      email: user_info["email"]
    }

    redirect_to countdown_events_path, notice: "ログインしました"
  rescue OAuth2::Error => e
    redirect_to login_path, alert: "認証に失敗しました: #{e.message}"
  end

  # 認証失敗
  def failure
    redirect_to login_path, alert: "認証に失敗しました"
  end

  # ログアウト
  def destroy
    reset_session
    redirect_to login_path, notice: "ログアウトしました"
  end

  private

  def callback_url
    auth_callback_url(host: "localhost", port: 3001)
  end
end
