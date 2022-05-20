Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :tasks, only: %i[index create destroy] do
        patch :status, on: :member
      end
    end
  end
end
