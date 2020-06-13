require "test_helper"

describe OrderItem do
  describe "relationships" do
    it "had one product" do
      expect(order_items(:order_item1).product).must_be_instance_of Product
    end

    it "had one order" do
      expect(order_items(:order_item1).order).must_be_instance_of Order
    end
  end

  describe "validations" do
    let (:order_item4) {
      OrderItem.new(
        qty: 3,
        product_id: products(:product2).id,
        order_id: orders(:order2).id
      )
    }

    it "is valid for a order item with all required fields" do
      expect(order_item4.valid?).must_equal true
    end 

    it "has the required fields" do
      order_item4.save
      new_order_item = OrderItem.last
    
      [:qty].each do |field|
        expect(new_order_item).must_respond_to field
      end
    end

    it "is invalid without a qty" do
      order_item4.qty = nil
      
      expect(order_item4.valid?).must_equal false
      expect(order_item4.errors.messages).must_include :qty
    end

    it "cannot creat a new order_item with a non integer qty" do
      order_item4.save
      order_item5 = OrderItem.new(
        qty: 3.00,
        product_id: products(:product2).id,
        order_id: orders(:order2).id
      )
      expect(order_item5.valid?).must_equal false
      expect(order_item5.errors.messages).must_include :qty
    end

  end

  describe "cart" do 
    it "will have unique products (keys)" do 





    end 

    it "will remove product from cart" do 



    end 




  end 
end
