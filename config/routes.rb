Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  post 'like', to: 'likes#create', as: 'add_like'
  delete 'unlike', to: 'likes#destroy', as: 'remove_like'
  
  post 'follow', to: 'follows#create', as: 'follow'
  delete 'unfollow', to: 'follows#destroy', as: 'unfollow'

  get 'profiles/:name', to: 'users#show', as: 'show_user_profile'

  root 'photos#index'
end
