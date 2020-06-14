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
end
