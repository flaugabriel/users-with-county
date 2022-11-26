Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/info', to: 'api#info'
      resources :addresses
      resources :counties do
        collection do
          put 'update_status/:id', to: 'counties#update_status'
          get 'show_user/:id', to: 'counties#show_user'
        end
      end
      resources :users
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
