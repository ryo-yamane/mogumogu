Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tweets#index'
  resources :tweets do
    resources :comments, only: [:create]
    collection do
      get 'search'
    end
  end
  resources :users, only: %i[index show]

  resources :likes, only: %i[create destroy]
end
