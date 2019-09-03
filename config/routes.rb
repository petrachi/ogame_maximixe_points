Rails.application.routes.draw do
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
      get 'building_advisor'
      get 'research_advisor'
      get 'artillery_advisor'
    end
  end
  resources :researches do
    member do
      post 'increment_level'
      post 'upto_level'
    end
  end

  root to: 'players#index'
end
