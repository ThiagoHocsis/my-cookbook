Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :recipes, only: [:show, :new, :create, :edit, :update, :index, :destroy] do

    get "search", on: :collection

    member do
      post 'favorite'
      delete 'favorite', to: 'recipes#unfavorite', as: 'unfavorite'
      post 'share'
    end
  end

  resources :cuisines, only: [:show, :new, :create]
  resources :recipe_types, only: [:show, :new, :create]
end
