Rails.application.routes.draw do

  resources :products, only: [:index, :show]
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  resources :users do
    resources :products, controller: 'users/products'
  end

  get   '/login' => 'sessions#new'
  post  '/login' => 'sessions#create'
  get   '/logout' => 'sessions#destroy'

  get   'home/index'

  root  'home#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
