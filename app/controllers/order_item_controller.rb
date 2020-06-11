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

  def remove_from_cart 
    session[:order_items] = OrderItem.remove_from_cart(session["order_items"], params["format"].to_i)
    #THIS IS PARAMS: {"_method"=>"delete", "authenticity_token"=>"xxp4QJVjqTNKxmdNcR6GlEz4S1fN5m54uplkVFD4sEBFKL/K81Rfextg5H0P3CXm57eZ1CRNcdqPwMESDSG77w==", "controller"=>"order_item", "action"=>"remove_from_cart", "format"=>"8"}
    puts params
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
