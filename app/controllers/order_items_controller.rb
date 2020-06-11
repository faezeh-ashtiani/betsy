class OrderItemsController < ApplicationController

  def add_to_cart
    order = Order.find_by(id: session[:order_id])
    if session[:order_id].nil?
      order = Order.create()
      session[:order_id] = order.id
    end 
      
    

  end 

end
