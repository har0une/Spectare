# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get '/movies/surprise', to: 'movies#surprise' # Put this first
  resources :movies, only: [:show]
  get 'about', to: 'home#about'
  get '/profile', to: 'profiles#show', as: :profile
  # Minimal members routes so /members/:id/edit is available
  resources :members, only: %i[edit update]
end
