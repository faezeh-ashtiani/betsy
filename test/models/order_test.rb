require "test_helper"

describe Order do
  describe "order to order item relation" do

    it "can have many order_items" do
      expect(orders(:order1)).must_respond_to :order_items
      expect(orders(:order1).order_items.length).must_equal 3
      orders(:order1).order_items.each do |order_item|
        expect(order_item).must_be_instance_of OrderItem
      end
    end

    it "has many products thrugh oreder_items" do
      expect(orders(:order1)).must_respond_to :products
      expect(orders(:order1).products.length).must_equal 3
      orders(:order1).products.each do |product|
        expect(product).must_be_instance_of Product
      end
    end

  end

  describe "validations" do
    let (:order4) {
      Order.new(
        name: "Fa the guest",
        credit_card: "1234567890123456",
        status: "paid"
      )
    }

    it "is valid for a order with all required fields" do
      expect(order4.valid?).must_equal true
    end 

    it "has the required fields" do
      order4.save
      new_order = Order.last
    
      [:name, :credit_card, :status].each do |field|
        expect(new_order).must_respond_to field
      end
    end

    it "is invalid without a name" do
      order4.name = nil
    
      expect(order4.valid?).must_equal false
      expect(order4.errors.messages).must_include :name
    end

    it "is invalid without a credit card" do
      order4.credit_card = nil
    
      expect(order4.valid?).must_equal false
      expect(order4.errors.messages).must_include :credit_card
    end

    it "cannot creat a new order with a creditcard number that is not 16 digits" do
      order4.credit_card = "1111"
    
      expect(order4.valid?).must_equal false
      expect(order4.errors.messages).must_include :credit_card
    end

    it "is invalid without a status" do
      order4.status = nil
    
      expect(order4.valid?).must_equal false
      expect(order4.errors.messages).must_include :status
    end

    it "cannot creat a new order with a status other than paid or complete" do
      order4.status = "something else"
    
      expect(order4.valid?).must_equal false
      expect(order4.errors.messages).must_include :status
    end

  end

  describe "model methods" do 

    it "will give the correct total of an order" do 
      prod1 = products(:product1) #2.99
      prod2 = products(:product2) #9.99
      order_hash = {}

      order_hash[prod1] = 1
      order_hash[prod2] = 1

      total = Order.order_total(order_hash)
      expect(total).must_equal 14.278
    end   


  end 
end
