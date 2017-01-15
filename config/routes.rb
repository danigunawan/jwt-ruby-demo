Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions
  resources :homes
  resources :users
  get 'home' => "homes#index"
  # root 'homes#index'
  root 'homes#dashboard'
  get 'dashboard' => 'homes#dashboard'
end
