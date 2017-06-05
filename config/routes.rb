Rails.application.routes.draw do

  get '/', to: 'home#index'
  get '/ideas', to: 'home#index'

  resources :home, only: [:index]
  resources :ideas
  resources :users, only: [:new, :create]

end
