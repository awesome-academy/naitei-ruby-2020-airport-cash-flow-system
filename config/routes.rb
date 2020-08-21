Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    namespace :accountant do
      resources :incomes, only: %i(index new create)
    end

    namespace :admin do
      resources :users, only: %i(new create)
    end

    resources :requests, only: %i(new create index)
  end
end
