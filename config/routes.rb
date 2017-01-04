Rails.application.routes.draw do

  get '/signup' => 'user#new'
  post '/signup' => 'user#create'

  get   '/login' => 'sessions#new'
  post  '/login' => 'sessions#create'
  get   '/logout' => 'sessions#destroy'

  get   'home/index'

  root  'home#index'
end
