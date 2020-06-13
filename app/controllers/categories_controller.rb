class CategoriesController < ApplicationController

  def index  
    # this is not being used anywhere
    # can we take out this action?
    @categories = Category.category_options
  end 

  


end
