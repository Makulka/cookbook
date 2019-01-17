Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  
  resources :users, except: [:new]
  
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :recipes, except: [:destroy] do
    resources :comments, only: [:create, :destroy]
  end
  
  resources :user_recipes, only: [:new, :create, :destroy]
  
  get "search_recipes", to: "recipes#search"
  
  resources :friendships, only: [:new, :create, :destroy]
  
  get "search_friends", to: "users#search"
  
  get "my_friends", to: "users#my_friends"
  get "my_recipes", to: "users#my_recipes"
  
  resources :categories, only: [:show]
  
  get "chatroom", to: "chatroom#index"
  
  post "message", to: "messages#create"
  
  mount ActionCable.server, at: "/cable"
end
