Tacomanager::Application.routes.draw do
  devise_for :users
  scope "(:locale)", locale: /en|es/ do
    resources :users

    resources :establishments do
      resources :food
      resources :comments, only: :create
      resources :orders do
        resources :comments, only: :create
        resources :payments
      end
    end

    root :to => 'home#index'
  end
end
