Tacomanager::Application.routes.draw do
  scope "(:locale)", locale: /en|es/ do
    resources :users
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
