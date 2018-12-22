Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  
  resources :users, except: [:new]
  
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :recipes
  
  resources :user_recipes, except: [:edit, :update]
  
  get "search_recipes", to: "recipes#search"
  
  resources :friendships, except: [:edit, :update]
  
  get "search_friends", to: "users#search"
  
  get "my_friends", to: "users#my_friends"
  get "my_recipes", to: "users#my_recipes"
end
