class OrdersController < ApplicationController

  def show 
    @order = Order.find_by(id: params[:id])
  end 

  def new 
    @order = Order.new
  end 

  def create 
    @order = Order.new(order_params) 
    @order.status = "paid"
    if @order.save
      flash[:status] = "Order Placed!"
      @order.order_items = session[:order_items].map{|item| OrderItem.find_by(id: item["id"])}
      @order.order_items.each do |item|
        product = Product.find_by(id: item.product_id)
        Product.update_quantity(product.id, item.qty)
        product.reload
      end 
      session[:order_items] = nil
      redirect_to order_path(@order.id)
    else
      flash[:error] = "Order could not be placed!"
      render :new 
      return
    end 
  end 

  def update 
    order = Order.find_by(id: params[:id])
    if order.nil? 
      flash[:error] = "Contact merchant, something went wrong :("
      return redirect_to root_path 
    end 
    if order.update(status: "canceled") && Order.restock_canceled_items(order)
      flash[:status] = "Order successfully canceled!"
      return redirect_to root_path
    else 
      flash[:error] = "something went wrong :("
      redirect_to order_path
      return
    end 
  end 



  private 

  def order_params 
   return params.require(:order).permit(:name, :credit_card)
  end 
end
