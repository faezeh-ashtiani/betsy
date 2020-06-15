class ProductsController < ApplicationController

  before_action :require_login, only: [:new, :create, :destroy, :edit]
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def category_products
    @category = Category.find_by_id(params[:category_id])
    @category_products = @category.products #.sort{ |a, b| b.average_rating <=> a.average_rating }
  end

  def show
    if @product.nil?
      head :not_found
      return
    end
    @reviews = @product.reviews
  end

  def new
    @product = Product.new
  end 

  def create
    @product = Product.new(new_product_params)
    if session[:user_id] == nil
      redirect_to root_path 
    end
    @product.merchant_id = session[:user_id]

   
    if @product.save
      flash[:status] = "Product Created!"
      
      redirect_to product_path(@product.id)
    else
      render :edit, status: :bad_request
      return
    end 
  end 

  # def edit    #TODO is this even needed?
  #   if @product.nil?
  #     head :not_found
  #     return
  #   end

  # end 

  def update
    if @product.nil?
      head :not_found
      return
    elsif @product.update(new_product_params)
      flash[:success] = "Product updated successfully"
      redirect_to product_path 
      return
    else # save failed :(
      flash.now[:error] = "Something happened. Product not updated."
      render :edit, status: :bad_request # show the form view again
      return
    end

  end 

  def destroy 

  end 

  private 

  def new_product_params 
    return params.require(:product).permit(:name, :price, :img_url, :description, :qty, category_ids: [])
  end 

  def find_product
    @product = Product.find_by(id: params[:id])
  end
  
end
