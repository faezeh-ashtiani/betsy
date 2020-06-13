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

    describe "new" do
      before do
        merchant = perform_login()
      end

      it "can get the new_product_path" do
        get new_product_path
  
        must_respond_with :success
      end
    end

    describe "create" do

      before do
        @merchant = perform_login()
      end
  
     let(:product_hash) { 
      {
        product: {
          name: "Item",
          price: 2.99,
          img_url: 'https://live.staticflickr.com/65535/49992513867_b7f9f8ffb0_m.jpg',
          description: 'Here is a description',
          qty: 4
        }
      }
    }
  
      it "can create a product" do
        expect {
          post products_path, params: product_hash
        }.must_differ 'Product.count', 1
    
        must_respond_with :redirect
        must_redirect_to product_path(Product.last.id)
        expect(Product.last.name).must_equal product_hash[:product][:name]
        expect(Product.last.price).must_equal product_hash[:product][:price]
        expect(Product.last.description).must_equal product_hash[:product][:description]
        expect(Product.last.img_url).must_equal product_hash[:product][:img_url]
        expect(Product.last.qty).must_equal product_hash[:product][:qty]
        expect(Product.last.merchant_id).must_equal @merchant.id
      end
  
      # it "will not create a book with invalid params" do
      #   book_hash[:book][:title] = nil
  
      #   expect {
      #     post books_path, params: book_hash
      #   }.must_differ "Book.count", 0
  
      #   must_respond_with :bad_request
      # end
    end

  end
end
