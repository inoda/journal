Rails.application.routes.draw do
  root to: "sessions#new"

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :posts
end
