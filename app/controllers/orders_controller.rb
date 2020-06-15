class OrdersController < ApplicationController


  def show 
    @order = Order.find_by(id: params[:id])
  end 

  def new 
    @order = Order.new
  end 

  def create 
    @order = Order.new(order_params)
    @order.qty = session[:order_items].length 
    if @order.save
      flash[:status] = "Order Placed!"
      @order.order_items = session[:order_items].map{|item| OrderItem.find_by(id: item["id"])}
    
      session[:order_items] = nil
      redirect_to order_path(@order.id)
    else
      render :new 
      return
    end 
  end 



  private 

  def order_params 
   return params.require(:order).permit(:name, :credit_card)
  end 
end
