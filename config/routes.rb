Rails.application.routes.draw do
  get "/" => "items#index"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items
  resource :carts, only: [:edit,:create]
  patch "/carts" => "carts#add"
  resources :carts, only: [:update,:destroy]

  resources :history, only: [:create, :edit, :update]
end