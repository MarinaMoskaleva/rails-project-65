# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  scope module: :web do
    post '/auth/:provider', to: 'auth#request', as: :auth_request
    get '/auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete '/auth/logout', to: 'auth#destroy'
    get '/profile', to: 'profile#index'

    resources :bulletins do
      member do
        patch :to_moderation, :archive
      end
    end

    root to: 'bulletins#index'

    namespace :admin do
      root to: 'bulletins#on_moderation'
      resources :bulletins, only: %i[index show] do
        get :on_moderation, on: :collection
        member do
          patch :publish, :archive, :reject
        end
      end
      resources :categories
    end
  end
end
