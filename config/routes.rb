Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  get 'parts/add', to: 'parts#add', as: :add_parts
  resources :parts

  resources :projects do
    resources :requirements
  end
  post 'projects/:id/complete', to: 'projects#complete', as: :complete_project
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
