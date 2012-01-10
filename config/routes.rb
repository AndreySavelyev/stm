Stm::Application.routes.draw do

  get "login"  => "sessions#new" , :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  get "signup" => "users#new", :as => 'signup'

  resources :users
  resources :sessions
  root :to => "users#index"

 end
