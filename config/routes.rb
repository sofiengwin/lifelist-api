Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :bucketlists do
        resources :items
      end
      resources :users
    end
  end
end
