Rails.application.routes.draw do
  
  get 'products/index'

  root to: 'products#index'

  resources :merchants
  resources :products
  resources :carts
  resources :order_items
  resources :categories
  resources :reviews
  

end
