class ProductsController < ApplicationController

  before_action :require_login, only: [:new, :create, :destroy, :edit]

  def index
    @products = Product.all
  end

  def new
    
  end 

  def create

  end 

  def edit 

  end 

  def update

  end 

  def destroy 

  end 
end
