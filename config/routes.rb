Rails.application.routes.draw do
  
  root 'events#index'
  devise_for :users
  resources :attendances
  resources :events
  resources :users do
    resources :events
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
