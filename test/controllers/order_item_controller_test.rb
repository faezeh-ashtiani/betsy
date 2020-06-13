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
    end 
  end 


  describe "remove from cart" do 


  end 
end
