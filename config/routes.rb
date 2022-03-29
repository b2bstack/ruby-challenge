Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "application#home"


  scope :api, defaults: { format: :json } do

    
    devise_for :users, controllers: { sessions: :sessions },
                       path_names: { sign_in: :login }
    resource :user, only: [:show, :update]



    resources :todo_lists, only: [:index, :show, :create, :update, :destroy]


  end
end
