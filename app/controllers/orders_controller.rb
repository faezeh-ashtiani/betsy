class OrdersController < ApplicationController


  def show 
    @order = Order.find_by(id: params[:id])
  end 

  def new 
    @order = Order.new
  end 

  def create 
    @order = Order.new(order_params) 
    if @order.save
      flash[:status] = "Order Placed!"
      @order.order_items = session[:order_items].map{|item| OrderItem.find_by(id: item["id"])}
      @order.order_items.each do |item|
        Product.update_quantity(item.product_id, item.qty)
      end 
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
