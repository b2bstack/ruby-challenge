Rails.application.routes.draw do
  apipie
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, format: :json do
    namespace :v1 do
      resources :users do
        collection do
          post :login
        end

        resources :todos do
          post :clear_items, on: :member

          resources :todo_items, path: :items, only: [:show, :create, :update, :destroy] do
            post :set_status, on: :member, param: :status
            post :archive, on: :member
            post :execute, on: :member
          end
        end
      end
    end
  end
end
