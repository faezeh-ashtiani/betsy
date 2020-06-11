class OrdersController < ApplicationController

  def new 
    @order = Order.new
  end 

  def create 
    @order = Order.new(order_params)
    if @order.save
      flash[:status] = "Order Placed!"
      redirect_to products_path
    else
      render :new 
      return
    end 
  end 

  def check_out 

    

  end 

  private 

  def order_params 
   return params.require(:order).permit(:name, :credit_card)
  end 
end
