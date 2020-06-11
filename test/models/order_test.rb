require "test_helper"

describe Order do
  describe "order to order item relation" do

    let(:order_item2) { order_items(:order_item2) }
    let(:order_item3) { order_items(:order_item3) }
  
    it "order item belong to order" do
      expect(order_item2.order.name).must_equal "tom"
    end

    it "order can have many order items" do
      expect(order_item2.order.name).must_equal "tom"
      expect(order_item3.order.name).must_equal "tom"
    end

  end
end
