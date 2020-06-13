require "test_helper"

describe OrderItem do
  describe "cart" do 
    it "returns a hash for product and quantity from session" do 
      product1 = products(:product1)
      product2 =  products(:product2)
      item1 =  OrderItem.create!(qty: 2, product_id: product1.id)
      item2 =  OrderItem.create!(qty: 3, product_id: product2.id)
      cart =  [item1, item2]
      order = OrderItem.display_items(cart)


      order.must_be_instance_of Hash 
      order.length.must_equal 2 

      order.each do |key, val|
        key.must_be_instance_of Product 
      end 
    end 

    it "will remove product from cart" do 
      product1 = products(:product1)
      product2 =  products(:product2)
      item1 =  OrderItem.create!(qty: 2, product_id: product1.id)
      item2 =  OrderItem.create!(qty: 3, product_id: product2.id)

      cart = [item1, item2]
      updated_cart = OrderItem.remove_from_cart(cart, product1.id)
      updated_cart.length.must_equal 1
    end 

  end 
end
