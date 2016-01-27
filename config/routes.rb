Rails.application.routes.draw do
  root "home#index"
  devise_for :admins
  resources :products
  resources :sessions, only: [:new, :create, :destroy]
  apipie
  resources :posts, only: [:index, :new, :create]
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :posts, only: [:index, :new, :create, :show]
      resources :admins, only: :index
      #api登录，退出
      devise_scope :admin do
        post "/sign_in", :to => 'session#create'
        delete "/sign_out", :to => 'session#destroy'
      end
    end
  end

  namespace :api do
    namespace :v2 do
      resources :sessions, only: [:index, :create, :show, :update, :destroy]
      resources :users
    end
  end
end
