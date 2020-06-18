require "test_helper"

describe Merchant do
  
  describe "merchant product relations" do
    
    it "can have many products" do
      expect(merchants(:merchant1)).must_respond_to :products
      expect(merchants(:merchant1).products.length).must_equal 3
  
      merchants(:merchant1).products.each do |product|
        expect(product).must_be_instance_of Product
      end
    end
    
    it "can have zero products" do
      merchant2 = merchants(:merchant2)
      expect(merchant2.products.length).must_equal 0
    end
  end

  describe "validations" do
    let (:merchant3) {
      Merchant.new(
        username: "Fa the Merch",
        email: "fa@merch.com",
        uid: 3,
        provider: "github",
      )
    }

    it "is valid for a merchant with all required fields" do
      expect(merchant3.valid?).must_equal true
    end 

    it "has the required fields" do
      merchant3.save
      new_merchant = Merchant.last
    
      [:username, :email, :uid, :provider].each do |field|
        expect(new_merchant).must_respond_to field
      end
    end

    it "is invalid without a username" do
      merchant3.username = nil
    
      expect(merchant3.valid?).must_equal false
      expect(merchant3.errors.messages).must_include :username
    end

    it "cannot creat a new merchant with the same username in the same provider" do
      merchant3.save
      merchant4 = Merchant.new(
        username: "Fa the Merch",
        email: "fa@blah.com",
        uid: 4,
        provider: "github",
      )
      expect(merchant4.valid?).must_equal false
      expect(merchant4.errors.messages).must_include :username
    end

    it "is invalid without a email" do
      merchant3.email = nil
    
      expect(merchant3.valid?).must_equal false
      expect(merchant3.errors.messages).must_include :email
    end

    it "cannot creat a new merchant with the same email in the same provider" do
      merchant3.save
      merchant4 = Merchant.new(
        username: "blah",
        email: "fa@merch.com",
        uid: 4,
        provider: "github",
      )
      expect(merchant4.valid?).must_equal false
      expect(merchant4.errors.messages).must_include :email
    end

    it "is invalid without a uid" do
      merchant3.uid = nil
    
      expect(merchant3.valid?).must_equal false
      expect(merchant3.errors.messages).must_include :uid
    end

    it "cannot creat a new merchant with the same uid in the same provider" do
      merchant3.save
      merchant4 = Merchant.new(
        username: "blah",
        email: "fa@blah.com",
        uid: 3,
        provider: "github",
      )
      expect(merchant4.valid?).must_equal false
      expect(merchant4.errors.messages).must_include :uid
    end

    it "is invalid without a provider" do
      merchant3.provider = nil
    
      expect(merchant3.valid?).must_equal false
      expect(merchant3.errors.messages).must_include :provider
    end

  end

  describe "merchant model methods" do
    describe "create_merchant_from_github" do 
      it "creates a valid merchant with a valid auth hash" do 
      end 

      it "creates a valid merchant even if auth hash doesn't provide access to name" do 
      end 
    end 
  
    describe "get_all_orders" do 
      it "returns an array of all orders that include at least one of the merchant's product" do 
      end 

      it "returns an array that does not contain duplicate orders" do 
      end 

      it "returns an array that does not include an order that does not include at least one of it's products" do
      end

      it "returns an empty array when a merchant has 0 products" do 
      end 
    end 
  
    describe "get_orders_by_status" do 
      it "returns an array of orders only with the specified status" do 
      end 

      it "returns an empty array when a merchant has 0 products with specified status" do 
      end 
    end 
  
    describe "find_my_order_items" do 
      it "returns an array of order items from an order that is associated with merchant" do
      end 

      it "does not return any order items that are not associated with merchant" do 
      end 

      it "returns an empty array if none of the merchant's products are in the order" do 
      end 

    end 
  
    describe "earnings_per_order" do 
      it "returns the earnings a merchant made on a given order" do 
      end 

      it "returns 0.00 if there are no merchant products in the order" do 
      end 
    end 
  
    describe "total_revenue" do 
      it "returns total revenue of a merchant from a collection of orders" do 
      end 

      it "returns 0.00 if there are no orders associated with merchant" do 
      end 
    end 
  end
end
