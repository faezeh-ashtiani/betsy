require "test_helper"

describe OrderItemController do
  describe "add to cart" do 
    it "will add product to empty cart!" do 
      product = products(:product1)

      par = {
        id: 1, 
        post: { qty: 2 }
      }
      post add_to_cart_path(product.id), params: par
      get cart_path 

      expect(@cart).nil?.must_equal false
      must_respond_with :ok
    end 

    it "will not add product if there is not enough inventory" do 
      product = products(:product2)
      par = {
        id: 1, 
        post: { qty: 5 }
      }
      post add_to_cart_path(product.id), params: par 
      expect(@cart).must_equal nil
      must_redirect_to root_path
    end 
  end 


  describe "remove from cart" do 
    it "will remove product from cart" do 
      product = products(:product1)

      par = {
        id: 1, 
        post: { qty: 2 }
      }
      post add_to_cart_path(product.id), params: par
      get cart_path 

      expect(@cart).nil?.must_equal false

      param = {
        "format": product.id
      }
      post remove_from_cart_path, params: param
      get cart_path
      # product = products(:product1)
      # product2 = products(:product2)

      # session = {
      #   order_items: []
      # }
      # session[:order_items] << OrderItem.create!(qty: 1, product_id: product.id)
      # session[:order_items] << OrderItem.create!(qty: 1, product_id: product2.id)

      # get cart_path, params: {format: product.id}

      # expect(@cart.length).must_equal 1 
      # @cart.length.must_equal 2
   
      # post remove_from_cart_path(par2[:id])

      # expect(@cart.length).must_equal 1 
    end 


  end 
end
