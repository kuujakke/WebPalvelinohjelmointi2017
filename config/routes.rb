Rails.application.routes.draw do
  resources :users
  root 'breweries#index'
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  get 'signup', to: 'users#new'
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

end
