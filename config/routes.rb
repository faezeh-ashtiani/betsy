Rails.application.routes.draw do
  
  get 'products/index'

  root to: 'products#index'

  resources :merchants
  resources :products
  resources :carts
  resources :order_items
  resources :categories 

  get '/categories/:category_id/products', to: 'products#category_products', as: 'category_products'
  
  resources :reviews
  

end
