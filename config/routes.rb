Rails.application.routes.draw do


  get 'sessions/new'

  # get 'users/new'
  resources :ideas do
      resources :reviews, shallow: true, only: [:create, :destroy]
end
resource :session, only: [:new, :create, :destroy]
resources :users, only: [:new, :create]
  # get 'reviews/new'

  # get 'ideas/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
