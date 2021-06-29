Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :destroy, :show]
  namespace :admin do
    resources :users
  end
end
