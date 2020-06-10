class ProductsController < ApplicationController

  def index
  end

  def category_products
    category = Category.find_by_id(params[:category_id])
    @category_products = category.products #.sort{ |a, b| b.average_rating <=> a.average_rating }
  end
end
