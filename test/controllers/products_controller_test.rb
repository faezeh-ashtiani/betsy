require "test_helper"

describe ProductsController do
  describe "index" do
    it "succeeds when there are products" do
      get products_path
      must_respond_with :success
    end

    it "succeeds when there are no products" do
      Product.all do |product|
        product.destroy
      end

      get products_path

      must_respond_with :success
    end
  end

  describe "category_products" do
    it "succeeds when there are products in a category" do
      category_id = categories(:category1).id
      get category_products_path(category_id)
      must_respond_with :success
    end

    it "succeeds when there are no products" do
      Product.destroy_all
      category_id = categories(:category1).id
      get category_products_path(category_id)

      must_respond_with :success
    end
  end

  describe "show" do
    before do
      @product = Product.first
    end

    it "will get show for valid ids" do
      # Arrange
      valid_product_id = @product.id
  
      # Act
      get "/products/#{valid_product_id}"
  
      # Assert
      must_respond_with :success
    end
  
    it "will respond with not_found for invalid ids" do
      # Arrange
      invalid_product_id = -1
  
      # Act
      get "/products/#{invalid_product_id}"
  
      # Assert
      must_respond_with :not_found
    end
  end
end
