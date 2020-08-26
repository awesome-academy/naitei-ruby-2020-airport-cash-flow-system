Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/login", to: "sessions#new", as: "login"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    namespace :accountant do
      resources :incomes, only: %i(index new create)
      resources :suppliers, except: %i(show destroy)
      resources :requests, only: %i(index update show)
    end

    namespace :admin do
      resources :users, only: %i(new create)
    end

    namespace :manager do
      resources :requests, only: %i(show update index)
    end

    namespace :accountmanager do
      resources :suppliers, except: %i(show destroy)
    end

    resources :requests, except: :destroy
  end
end
