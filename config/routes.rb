
Rails.application.routes.draw do
  root to: "toppages#index" 
  
  get "signup", to: "users#new"
  
  resources :users, only: [:show, :new, :create] do
    member do
      get 'profile', to: 'users#profile'
      patch 'profile', to: 'users#profile_update'
      get 'image', to: 'users#image'
      post 'image', to: 'users#image_update'
      get 'email', to: 'users#email'
      patch 'email', to: 'users#email_update'
      get 'password', to: 'users#password'
      patch 'password', to: 'users#password_update'
      get "finished", to: "users#finished"
      get "reviews", to: "users#reviews"
    end
  end
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete 'logout', to: 'sessions#destroy'
  
  resources :books, only: [:new, :show]
  resources :ownerships, only: [:create, :destroy]
  
  resources :reviews, only: [:show, :new, :create, :destroy, :edit, :update]
end
