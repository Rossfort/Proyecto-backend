Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      namespace :admin do
        resources :categories
        resources :orders
        resources :products do
          member do
            get :properties
          end
          resources :variants, only: %i[index create]
        end
        resources :variants, except: %i[index create] do
          get '/restore', to: 'variants#restore'
        end
        get '/products/:id/restore', to: 'products#restore'
      end
      resources :categories, param: :name, only: %i[index show] do
        member do
          get :category_properties
        end
      end
      resources :products, only: %i[index show] do
        get :search, on: :collection
      end
      resources :variants, only: [:index]
      resources :orders, only: [:create]
      resources :properties
      resources :contacts, only: [:create]

      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/current_user', to: 'admins#current'

      post '/payment', to: 'payments#commit'
      get '/payments/:uuid', to: 'payments#show'
    end
  end
end
