Mittenberry::Application.routes.draw do
  root :to => 'pages#index'

  resources :orders, :only => [:edit] do
    collection do
      post 'add_details'
    end

    member do
      post 'place'
    end
  end
  resources :order_products, :only => [:create]
  resources :payments, :only => [:create]
end
