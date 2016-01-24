Rails.application.routes.draw do
  resources :products
  apipie
  resources :posts, only: [:index, :new, :create]
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      # 原文有 microposts, 我们现在把它注释掉
      # resources :microposts, only: [:index, :create, :show, :update, :destroy]

      resources :sessions, only: [:create]
      resources :posts, only: [:index, :new, :create]
    end
  end
end
