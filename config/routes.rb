Mittenberry::Application.routes.draw do
  root :to => 'pages#index'

  resources :order_products, :only => [:create]
  resources :payments, :only => [:create]
end
