Rails.application.routes.draw do
  devise_for :users
  resources :movies do
    get '/page/:page', action: :index, on: :collection
  end
  
  namespace :admin do
    resources :users, only: %i[index show create edit update]
  end

  root "movies#index"
end
