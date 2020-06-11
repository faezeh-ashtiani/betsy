Rails.application.routes.draw do
  
  get 'products/index'

  root to: 'products#index'
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create"

  resources :merchants
  
  get '/merchant/:merchant_id/products', to: 'merchants#merchant_products', as: 'merchant_products'

  resources :products
  resources :orders, only: [:new, :create]
  resources :categories 
  #quin ---- 
  get '/categories/:category_id/products', to: 'products#category_products', as: 'category_products'

  

  get 'guest/cart', to: 'order_item#cart', as: 'cart'
  post 'products/:id/add-to-cart', to: 'order_item#add_to_cart', as: 'add_to_cart'

  post 'guest/cart/remove', to: 'order_item#remove_from_cart', as: 'remove_from_cart'
  #---- quin did this please keep
  
  
  resources :reviews
  

end
