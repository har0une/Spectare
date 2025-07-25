Rails.application.routes.draw do
  root to: "home#index"
  get "/movies/surprise", to: "movies#surprise"  # Put this first
  resources :movies, only: [ :show ]
  get "about", to: "home#about"
end
