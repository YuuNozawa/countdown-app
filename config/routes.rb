Rails.application.routes.draw do
  root to: redirect("/login")
  get    "/login",    to: "sessions#new",      as: :login
  get    "/auth/callback", to: "sessions#callback", as: :auth_callback
  get    "/auth/failure",  to: "sessions#failure"
  post "/logout",       to: "sessions#destroy", as: :logout
  scope "/countdown", as: "countdown" do
    resources :events, only: [ :index, :new, :create, :edit, :update, :destroy, :show ]
    resources :comments, only: [ :create ]
  end
end
