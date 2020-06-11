class OrderItemController < ApplicationController

  def add_to_cart   
    if session[:order_items] 
      session[:order_items] << OrderItem.create(qty: params[:post][:qty], product_id: params[:id])
    else
      session[:order_items] = []
      session[:order_items] << OrderItem.create(qty: params[:post][:qty], product_id: params[:id])
    end 
    
    session[:order_items].each do |item|
      product = Product.find_by(id: item[:product_id])
      puts product
    end 
    redirect_to product_path(params[:id])
  end 

  def cart
    @cart = [] 
    session[:order_items].each do |order_item|
        product = Product.find_by(id: order_item[:product_id])
      if !product.nil?
        @cart << product.name
      end 
    end

    return @cart
  end 
end
