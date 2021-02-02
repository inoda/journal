Rails.application.routes.draw do
  root to: "sessions#new"

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :posts do
    put :share, on: :member
    put :unshare, on: :member
    post :autosave, on: :collection
  end

  resources :prompts, only: [:create, :index, :destroy]

  resources :shared_posts, only: [:show, :index]
end
