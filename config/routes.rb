# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  # Movies
  get '/movies/surprise', to: 'movies#surprise'
  resources :movies, only: [:show]
  
  # Static pages
  get 'about', to: 'home#about'

  # Profile
  get '/profile', to: 'profiles#show', as: :profile
  get '/profile/watchlist', to: 'profiles#watchlist', as: :profile_watchlist
  get '/profile/favorites', to: 'profiles#favorites', as: :profile_favorites
  get '/profile/ratings', to: 'profiles#ratings', as: :profile_ratings

  # Watchlist actions
  post   '/profile/watchlist/:movie_id',   to: 'profiles#add_to_watchlist',    as: :add_to_watchlist_profile
  delete '/profile/watchlist/:movie_id',   to: 'profiles#remove_from_watchlist', as: :remove_from_watchlist_profile

  # Likes / Favorites actions
  post   '/profile/favorites/:movie_id',   to: 'profiles#add_to_favorites',    as: :add_to_favorites_profile
  delete '/profile/favorites/:movie_id',   to: 'profiles#remove_from_favorites', as: :remove_from_favorites_profile

  # Ratings actions

  get '/profile/ratings/:movie_id/new', to: 'profiles#new_rating', as: :new_profile_rating
  post   '/profile/ratings/:movie_id',     to: 'profiles#rate_movie',          as: :rate_movie_profile
  patch  '/profile/ratings/:movie_id',     to: 'profiles#update_rating',      as: :update_rating_profile

  # Minimal members routes
  resources :members, only: %i[edit update]
end
