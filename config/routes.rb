Rails.application.routes.draw do
  get '/signup' => 'user#new'
  post '/signup' => 'user#create'

  # get   '/login' => 'session#new'
  # post  '/login' => 'session#create'
  # get   '/logout' => 'session#destroy'

  get   'home/index'

  root  'home#index'
end
