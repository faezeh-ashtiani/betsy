require "test_helper"

describe CategoriesController do
  
  describe "Guest users" do
    before do
      @category = Category.first
    end

    it "guest can access product by category" do
      get category_products_path(@category.id)
      must_respond_with :success
     
    end
  end
end
