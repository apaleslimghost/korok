Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  get 'parts/add', to: 'parts#add', as: :add_parts
  resources :parts

  resources :projects do
    resources :requirements
  end

  resources :sessions, only: [:new, :create, :delete]
  resources :users

  post 'projects/:id/complete', to: 'projects#complete', as: :complete_project

  get '/login', to: 'sessions#new', as: :log_in
  get '/logout', to: 'sessions#destroy', as: :log_out
end
