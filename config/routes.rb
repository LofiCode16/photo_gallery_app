Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  get 'profiles/:name', to: 'users#show', as: 'show_user_profile'

  root 'photos#index'
end
