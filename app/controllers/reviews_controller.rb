class ReviewsController < ApplicationController

  before_action :find_product

  def create
    if @product
      @review = Review.new(new_review_params)
      @review.product_id = @product.id
      # raise
      if @review.save
        flash[:success] = "Successful!"
      else
        flash.now[:warning] = "A problem occurred: Could not review"
        # render :new
        # return
      end
      redirect_to request.referrer || product_path(@product.id)
    end

  end

  private

  def new_review_params 
    params.permit(:rating, :description)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
