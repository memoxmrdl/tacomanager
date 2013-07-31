Tacomanager::Application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create', as: 'login'
  get '/logout' => 'sessions#destroy', as: 'logout'

  scope "(:locale)", locale: /en|es/ do
    namespace :dashboard do
      get '/' => 'establishments#index'
      resources :establishments do
        resources :foods
        resources :comment, only: :create
        resources :orders do
          resources :comment, only: :create
        end
      end
    end

    root :to => 'home#index'
  end
end
