Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :bucketlists do
        resources :item
      end
    end
  end
end
