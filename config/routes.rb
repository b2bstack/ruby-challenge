Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "application#home"


  scope :api, defaults: { format: :json } do

    get 'users/sign_up', to: 'users#sign_up'

    devise_for :users, controllers: { sessions: :sessions, registrations: :registrations } ,
                       path_names: { sign_in: :login }

    resource :user, only: [:show, :update, :sign_up]

   

    resources :items, only: [:index, :show, :create, :update, :destroy]
    get 'view_item', to: 'items#show'
    get 'remove_item', to: 'items#destroy'


    resources :todo_lists, only: [:index, :show, :create, :update, :destroy]
    get 'delete_todo_list', to: 'todo_lists#destroy'


  end
end
