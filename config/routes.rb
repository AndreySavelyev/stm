Stm::Application.routes.draw do

  get "login"  => "sessions#new" , :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  get "signup" => "users#new", :as => 'signup'

  resources :users
  resources :sessions
  resources :stories do
    member do
      post 'start'
      post 'finish'
      post 'accept'
      post 'reject'
    end
    post 'filter', :on => :collection
  end
  root :to => "stories#index"

 end