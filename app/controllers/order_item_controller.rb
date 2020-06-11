class OrderItemController < ApplicationController

  def add_to_cart   
    if session[:order_items] 
      session[:order_items] << OrderItem.create(qty: params[:post][:qty], product_id: params[:id])
    else
      session[:order_items] = []
      session[:order_items] << OrderItem.create(qty: params[:post][:qty], product_id: params[:id])
    end 
    redirect_to product_path(params[:id])
  end 

  def cart
    puts session[:order_items]
    @cart = [] 
    session[:order_items].each do |order_item|
        puts "THIS IS ORSER IDEM " + order_item.to_s
        product = Product.find_by(id: order_item["product_id"])
      if !product.nil?
        @cart << product.name
      end 
    end
    puts "This is cart" + @cart.to_s
    return @cart
  end 
end
