Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :recipes, only: [:show, :new, :create, :edit, :update] do

    get "search", on: :collection

  end

  resources :cuisines, only: [:show, :new, :create]
  resources :recipe_types, only: [:show, :new, :create]
end
