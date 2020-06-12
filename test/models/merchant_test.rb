require "test_helper"

describe Merchant do
  describe "merchant product relations" do
    let(:merchant) { merchants(:merchant1) }
  
    
    it "can have many products" do
      product1 = Product.create(name: "mask", price: 2.99, img_url: "www.pic.com", description: "this is a description", qty: 10, merchant_id: merchant.id)
      product2 = Product.create(name: "marker", price: 1.00, img_url: "www.marker.com", description: "better description", qty: 10, merchant_id: merchant.id)
      expect(merchant.products.length).must_equal 2
    end
    
    it "can have zero products" do
      merchant2 = merchants(:merchant2)
      
      expect(merchant2.products.length).must_equal 0
    end
  end
end
