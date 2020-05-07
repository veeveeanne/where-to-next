Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/destinations', to: 'static_pages#index'
  get '/destinations/new', to: 'static_pages#index'
  get '/listings', to: 'static_pages#index'
  get '/listings/:id/update', to: 'static_pages#index'

  namespace :api do
    namespace :v1 do
      resources :destinations, only: [:create, :index, :search]
      get '/destinations/search' => 'destinations#search'
      resources :listings, only: [:create, :index, :show, :update, :destroy, :search]
      get '/listings/search' => 'listings#search'
    end
  end
end
