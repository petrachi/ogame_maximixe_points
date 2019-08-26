Rails.application.routes.draw do
  namespace :admin do
    resources :buildings
    resources :building_effects
    resources :building_levels
    resources :planets
    resources :players

    root to: "buildings#index"
  end

  resources :buildings do
    member do
      post 'increment_level'
      post 'upto_level'
    end
  end
  resources :planets
  resources :players do
    member do
      get 'advisor'
    end
  end
  resources :researches do
    member do
      post 'increment_level'
      post 'upto_level'
    end
  end

  root to: 'home#index'
end
