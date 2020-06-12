class OrderItemController < ApplicationController

  def add_to_cart   

    
    if session[:order_items] 
      product = Product.find_by(id: params[:id])
      if Product.available?(product.id, params[:post][:qty])
        session[:order_items] << OrderItem.create(qty: params[:post][:qty], product_id: params[:id])
        return redirect_to product_path(params[:id])
      else
        flash[:error] = "Not enough inventory"
        redirect_to products_path
      end 

    else
      session[:order_items] = []
      product = Product.find_by(id: params[:id])

      if Product.available?(product.id, params[:post][:qty])
        session[:order_items] << OrderItem.create(qty: params[:post][:qty], product_id: params[:id])
        flash[:status] = "Successfully added!"
        return redirect_to product_path(params[:id])
      else
        flash[:error] = "Not enough inventory"
        return redirect_to products_path
      end 
    end 

    
  end 

  def remove_from_cart 
    puts "THIS IS SESSION in CONT #{session[:order_items]}"
    session[:order_items] = OrderItem.remove_from_cart(session[:order_items], params["format"])
    redirect_to cart_path
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
