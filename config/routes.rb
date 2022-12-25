# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :movies do
    resources :reviews, except: %i[index show]
  end

  namespace :admin do
    resources :users, only: %i[index edit update destroy]
    root 'users#index'
  end

  root 'movies#index'
end
