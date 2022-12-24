# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :movies do
    # get '/page/:page', action: :index, on: :collection
    resources :reviews, except: %i[index show]
  end

  namespace :admin do
    resources :users
    root 'users#index'
  end

  root 'movies#index'
end
