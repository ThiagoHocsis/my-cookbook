Rails.application.routes.draw do
  root to: 'home#index'

  resources :recipes
  resources :cuisines
end
