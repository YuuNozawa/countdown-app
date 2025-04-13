Rails.application.routes.draw do
  root to: "events#index"
  scope "/countdown", as: "countdown" do
    resources :events, only: [ :index, :new, :create, :edit, :update, :destroy ]
    resources :comments, only: [ :create ]
  end
end
