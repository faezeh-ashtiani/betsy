Rails.application.routes.draw do
  
  get 'products/index'

  root to: 'products#index'
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create"

  resources :merchants
  resources :products do
    resources :reviews, only: [:create]
  end
  resources :orders, only: [:new, :create]
  resources :categories

  get '/categories/:category_id/products', to: 'products#category_products', as: 'category_products'
  get '/merchant/:merchant_id/products', to: 'merchants#merchant_products', as: 'merchant_products'

  #quin ---- 
  get 'guest/cart', to: 'order_item#cart', as: 'cart'
  post 'order/check-out', to: 'order#check_out', as: 'check_out'
  post 'products/:id/add-to-cart', to: 'order_item#add_to_cart', as: 'add_to_cart'  
 
  post 'guest/cart/remove', to: 'order_item#remove_from_cart', as: 'remove_from_cart'
  #---- quin did this please keep

end
