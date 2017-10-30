Rails.application.routes.draw do
  # get 'sessions/new'
  resources :ideas do
    resources :reviews, shallow: true, only: [:create, :destroy]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  root 'welcome#index'
end
