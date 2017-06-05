Rails.application.routes.draw do

  get '/', to: 'ideas#index'
  get '/ideas', to: 'ideas#index'

  resources :home, only: [:index]
  resources :ideas, only: [:new, :create, :show, :edit, :destroy]
  resources :users, only: [:new, :create]

end
