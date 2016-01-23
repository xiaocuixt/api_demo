Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      # 原文有 microposts, 我们现在把它注释掉
      # resources :microposts, only: [:index, :create, :show, :update, :destroy]

      resources :sessions, only: [:create]
    end
  end
end
