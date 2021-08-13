Rails.application.routes.draw do
  root 'events#index'

  devise_for :users
  resources :attendances
  resources :events
  resources :users do
    resources :events
  end
  resources :events do
    resources :attendances
  end
  resources :orders

  namespace :admin do
    resources :users, :events, :attendances
    root 'users#show'
  end 


  # resources :events do 
  #   resources :event_submissions
  # end

  get 'test', to: 'static_pages#test'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
