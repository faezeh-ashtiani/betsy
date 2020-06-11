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

  def find_product
    @product = Product.find_by(id: params[:id])
  end
  
end
