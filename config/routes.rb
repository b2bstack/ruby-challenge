Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tasks, only: %i[index create destroy] do
        patch :status, on: :member
      end
    end
  end
end
