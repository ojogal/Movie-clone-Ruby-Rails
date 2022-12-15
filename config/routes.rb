Rails.application.routes.draw do
  devise_for :users
  resources :movies do
    get '/page/:page', action: :index, on: :collection
  end

  root "movies#index"
end
