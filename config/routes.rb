Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/info', to: 'api#info'
      resources :addresses do
        collection do
          get 'show_counties', to: 'addresses#show_counties'
        end
      end

      resources :counties do
        collection do
          put 'update_status/:id', to: 'counties#update_status'
          get 'show_user/:id', to: 'counties#show_user'
          get 'show_users', to: 'counties#show_users'
          delete 'destroy_user_county/:user_id', to: 'counties#destroy_user_county'
        end
      end

      resources :users do
        collection do
          put 'update_status/:id', to: 'users#update_status'
          put 'avatar/:id', to: 'users#avatar'
        end
      end
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
