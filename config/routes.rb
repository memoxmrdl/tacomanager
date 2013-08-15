Tacomanager::Application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create', as: 'login'
  get '/logout' => 'sessions#destroy', as: 'logout'

  scope "(:locale)", locale: /en|es/ do
    namespace :dashboard do
      root :to => 'dashboard#index'

      resources :establishments do
        resources :foods
        resource :comment, only: :create, to: 'comment#create'
        resource :vote, only: :create, to: 'vote#create'
        resources :orders, only: [:show, :create, :destroy, :update], as: 'orders' do
          resources :invitations, only: [:new, :create]
          resources :order_details, only: [:create, :update, :destroy]
        end
      end
      resources :image, only: [:create, :destroy]
    end

    root :to => 'home#index'
  end

  if Rails.env.test?
    post '/sessions/create' => 'sessions#create'
  end
end
