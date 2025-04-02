Rails.application.routes.draw do
  get "comments/create"
  root to: redirect("/countdown")
  get "/countdown", to: redirect("/countdown/index")

  get "countdown/index", to: "countdown#index", as: :index_countdown
  get "countdown/new", to: "countdown#new", as: :new_countdown
  get "up" => "rails/health#show", as: :rails_health_check
  resources :comments, only: [ :create ]
end
