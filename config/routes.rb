Tacomanager::Application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create', as: 'login'
  get '/logout' => 'sessions#destroy', as: 'logout'

  scope "(:locale)", locale: /en|es/ do
    namespace :dashboard do
      root :to => 'dashboard#index'

      resources :establishments do
        resources :foods
        resources :comment, only: :create
      end

      resources :orders do
        resources :orders_details
      end
    end

    root :to => 'home#index'
  end

  if Rails.env.test?
    post '/sessions/create' => 'sessions#create'
  end
end
