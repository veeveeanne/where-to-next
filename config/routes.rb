Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/destinations', to: 'static_pages#index'

  namespace :api do
    namespace :v1 do
      resources :destinations, only: [:index]
    end
  end
end
