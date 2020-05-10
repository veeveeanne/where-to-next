Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  get '/destinations', to: 'static_pages#index'
  get '/destinations/new', to: 'static_pages#index'
  get '/listings', to: 'static_pages#index'
  get '/listings/:id/update', to: 'static_pages#index'
  get '/travel', to: 'static_pages#index'

  namespace :api do
    namespace :v1 do
      get '/destinations/search' => 'destinations#search'
      resources :destinations, only: [:create, :index, :search]
      get '/listings/search' => 'listings#search'
      resources :listings, only: [:create, :index, :show, :update, :destroy]
      get 'airports/search' => 'airports#search'
      get 'airports/explore' => 'airports#explore'
      resources :airports, only: [:create]
      resources :flights, only: [:create]
    end
  end
end
