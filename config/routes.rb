Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  
  resources :users, except: [:new]
  
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :recipes
  
  resources :user_recipes, except: [:edit, :update]
  
  get "search_recipes", to: "recipes#search"
end
