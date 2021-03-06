Rails.application.routes.draw do

  # get 'users/new'
  #
  # get 'users/create'

  get '/', to: 'ideas#index', as: :home
  get '/ideas', to: 'ideas#index'

  patch '/ideas/:id/like', to: 'ideas#like', as: :ideas_like

  resources :home, only: [:index]
  resources :ideas, only: [:new, :create, :show, :edit, :destroy]
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :ideas do
    resources :reviews
  end

end
