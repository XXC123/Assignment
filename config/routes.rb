Rails.application.routes.draw do
    get 'sessions/new'

    root   "home_pages#home"
    get    "/home",       to: "home_pages#home"
    get    "/signup",     to: "users#new"
    post   "/signup",     to: "users#create"

    get    "/login",      to: "sessions#new"
    post   "/login",      to: "sessions#create"
    delete "/logout",     to: "sessions#destroy"

    resources :feedbacks
    resources :courses
    resources :users
    resources :categories
    resources :locations
end
