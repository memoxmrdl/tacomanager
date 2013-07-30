Tacomanager::Application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', as: :signout

  scope "(:locale)", locale: /en|es/ do
    namespace :dashboard do
      resources :establishments do
        resources :food
        resources :comments, only: :create
        resources :orders do
          resources :comments, only: :create
        end
      end
    end

    root :to => 'home#index'
  end
end
