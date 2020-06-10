class ProductsController < ApplicationController

  before_action :require_login, only: [:new, :create, :destroy, :edit]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end 

  def create
    @product = Product.create(new_product_params)
    if @product.save
      flash[:status] = "Product Created!"
      redirect_to products_path
    else
      render :new 
      return
    end 
  end 

  def edit 

  end 

  def update

  end 

  def destroy 

  end 

  private 

  def new_product_params 
    return params.require(:product).permit(:name, :price, :img_url, :description, :qty)
  end 
  def category_products
    category = Category.find_by_id(params[:category_id])
    @category_products = category.products #.sort{ |a, b| b.average_rating <=> a.average_rating }
  end
end
