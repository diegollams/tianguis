Rails.application.routes.draw do

  resources :products, only: [:index, :show]
  get '/signup' => 'user#new'
  post '/signup' => 'user#create'

  resources :users do
    resources :products, controller: 'users/products'
  end

  get   '/login' => 'sessions#new'
  post  '/login' => 'sessions#create'
  get   '/logout' => 'sessions#destroy'

  get   'home/index'

  root  'home#index'
end
