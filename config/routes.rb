Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :bucketlists do
        resources :items
      end
      resources :users

      post "/auth/login", to: "sessions#create", as: :login
      get "/auth/logout", to: "sessions#destroy", as: :logout
    end
  end
end
