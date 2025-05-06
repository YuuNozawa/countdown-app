class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # 全アクション実行前に require_login を呼ぶ
  before_action :require_login

  private

  # ログインしていなければ /login にリダイレクト
  def require_login
    unless session[:current_user]
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end
