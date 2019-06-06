Rails.application.routes.draw do
  get "/home", to: "static_pages#home"
  get "/login", to:"sessions#new"
  post "/login", to:"sessions#create"
  delete "/logout", to:"sessions#destroy"
  get "/signup", to:"users#new"
  post "/signup", to:"users#create"
  resources :users do
    resources :entries
    member do
      get :following, :followers
    end
  end
  resources :entries do
    resources :comments, only: %i(index create destroy)
  end

  resources :relationships, only: %i(create destroy)
  resources :entries, only: %i(index show create destroy)
  root "static_pages#home"
end
