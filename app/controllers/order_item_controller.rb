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
    if session[:order_items].nil? 
      redirect_to root_path
    else

      @cart = OrderItem.unique_items(session[:order_items])
      return @cart
    end 
  end 
end
