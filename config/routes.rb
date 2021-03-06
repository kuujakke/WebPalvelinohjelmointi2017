Rails.application.routes.draw do
  get 'styles/edit'

  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_activity', on: :member
  end
  root 'breweries#index'
  get 'brewerylist', to: 'breweries#list'
  get 'beerlist', to: 'beers#list'
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :ratings, only: [:index, :new, :create, :destroy]
  get 'signup', to: 'users#new'
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'
  resources :styles, only: [:index, :show, :edit]
end