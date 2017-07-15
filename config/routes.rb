Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get  '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users, except: [:new, :create] do
    member do
      get :following, :followers, :notifications, :join_groups
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy, :show] do
    resources :replies, only: :create, module: "microposts"
  end
  resources :relationships, only: [:create, :destroy]
  resources :groups do
    resources :comments, only: [:create, :destroy]
    member do
      get :members
    end
  end
  resources :group_users, only: [:create, :destroy]
  resources :books
  resources :book_users, only: [:create, :destroy]
end
