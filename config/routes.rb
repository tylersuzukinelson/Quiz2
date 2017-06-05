Rails.application.routes.draw do

  get 'users/new'

  get 'users/create'

  get '/', to: 'ideas#index', as: :home
  get '/ideas', to: 'ideas#index'

  resources :home, only: [:index]
  resources :ideas, only: [:new, :create, :show, :edit, :destroy]
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

end
