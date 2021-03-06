Rails.application.routes.draw do

  root 'sessions#welcome'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'students#new'
  delete '/logout' => 'sessions#destroy'
  get '/logout' => 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#omniauth'


  resources :emissions, only: [:new, :create, :edit, :update, :destroy, :index]

  resources :students do
    resources :emissions
  end

  resources :foods, only: [:index, :show, :edit, :update, :destroy] do
    resources :emissions, shallow: true
  end

end
