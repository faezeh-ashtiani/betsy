class CategoriesController < ApplicationController

  before_action :require_login, only: [:create]
  before_action :find_category, only: [:create]

  def new
    @category = Category.new
  end 

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "category added successfully"
      redirect_to root_path
      return
    else
      flash.now[:error] = "Something happened. category not added."
      render :new
      return
    end
  end

  # def edit    #TODO I dont think edit and update functionality is needed here but saving current work just in case (i accidently thought i needed it)

  #   if @category.nil?
  #     head :not_found
  #     return
  #   end
  # end 

  # def update
  #   if @category.nil?
  #     head :not_found
  #     return
  #   elsif @category.update(new_category_params)
  #     flash[:success] = "Category updated successfully"
  #     redirect_to root_path 
  #     return
  #   else # save failed :(
  #     flash.now[:error] = "Something happened. Category not updated."
  #     render :edit, status: :bad_request # show the form view again
  #     return
  #   end

  # end 

  private

  def category_params
    return params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find_by(id: params[:id])
  end

end
