class OrderItemController < ApplicationController

  def add_to_cart  
    if !Product.available?(params[:id], params[:post][:qty])
      flash[:error] = "Not enough in stock"
      return redirect_to root_path
    end 

    if session[:order_items] 
      session[:order_items] << OrderItem.create!(qty: params[:post][:qty], product_id: params[:id])
      flash[:status] = "Added to Cart!"
    else
      session[:order_items] = []
      session[:order_items] << OrderItem.create!(qty: params[:post][:qty], product_id: params[:id])
      flash[:status] = "Added to Cart!"
    end 
    redirect_to product_path(params[:id])
  end 

  def remove_from_cart 
    session[:order_items] = OrderItem.remove_from_cart(session[:order_items], params["format"])
    redirect_to cart_path
  end 

  def cart 
    if session[:order_items].nil? 
      flash[:error] = "You have nothing in your cart!"
      redirect_to root_path
    else
      @cart = OrderItem.display_items(session[:order_items])
      return @cart
    end 
  end 

end
