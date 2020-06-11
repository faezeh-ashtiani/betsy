Rails.application.routes.draw do
  
  get 'products/index'

  root to: 'products#index'
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create"

  #resources :merchants
  resources :products
  #resources :carts
  #resources :order_items
  resources :categories 

  get '/categories/:category_id/products', to: 'products#category_products', as: 'category_products'
  post 'order/check-out', to: 'order#check_out', as: 'check_out'

  get 'guest/cart', to: 'order_item#cart', as: 'cart'
  post 'products/:id/add-to-cart', to: 'order_item#add_to_cart', as: 'add_to_cart'
  
  
  resources :reviews
  

end
