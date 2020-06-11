class OrderItemsController < ApplicationController

  def add_to_cart
    # order = Order.find_by(id: session[:order_id])
    # if session[:order_id].nil?
    #   order = Order.create()
    #   session[:order_id] = order.id
    # end 

    session[:order_items] << OrderItems.create(qty: params[:qty], product_id: @product.id)
      
    
    order_items = OrderItems(qty: params[:qty], product_id: @product.id)

  end 

end
