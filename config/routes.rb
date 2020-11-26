Rails.application.routes.draw do
  resources :parts
  resources :projects do
    resources :requirements
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
