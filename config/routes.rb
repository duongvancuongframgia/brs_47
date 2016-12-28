Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  namespace :admin do
    root "static_pages#home"
    resources :categories, except: :show
    resources :users
    resources :books, only: [:index, :show]
  end
  resources :users, except: [:destroy, :index] do
    resources :following, only: :index
    resources :followers, only: :index
  end
  resources :books, only: [:index, :show] do
    resources :reviews
    resources :rates, except: :destroy
  end
  resources :relationships, only: [:create, :destroy]
end
