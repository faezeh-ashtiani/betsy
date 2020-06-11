class OrderItemsController < ApplicationController

  def add_to_cart
    # order = Order.find_by(id: session[:order_id])
    # if session[:order_id].nil?
    #   order = Order.create()
    #   session[:order_id] = order.id
    # end 
    if session[:order_items] 
      session[:order_items] << OrderItems.create(qty: params[:qty], product_id: @product.id)
    else
      session[:order_items] = []
      session[:order_items] << OrderItems.new(qty: params[:qty], product_id: @product.id)
    end 
      
    
    

  end 

end
