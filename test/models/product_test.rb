require "test_helper"

describe Product do

  describe "review relations" do
    let(:product) { products(:product1) }
  
    
    it "can have many reviews" do
      Review.create(rating: 3, description: "great", product_id: product.id)
      Review.create(rating: 4, description: "ok", product_id: product.id)
      
      expect(product.reviews.length).must_equal 2
    end
    
    it "can have zero reviews" do
      product2 = products(:product2)
      
      expect(product2.reviews.length).must_equal 0
    end
  end

  describe "category relations" do
  
    let(:product) { products(:product1) }
  
    it "can have many categories" do
      
      expect(product.categories.length).must_equal 2
      expect(product.categories.first.name).must_equal "Protest"
      expect(product.categories.last.name).must_equal "Covid 19"
    end
    
    it "can have zero categories" do
      product3 = products(:product3)
      
      expect(product3.categories.length).must_equal 0
    end
  end

  # describe "order relations" do
  
  #   let(:product) { products(:product1) }
  
  #   it "can have many orders" do
  #     Order.create(name: "chelsea", credit_card: 100, qty: 2, product_id: product.id)
  #     Order.create(name: "boo", credit_card: 121, qty: 3, product_id: product.id)

  #     expect(product.orders.length).must_equal 2
  #     expect(product.orders.first.name).must_equal "chelseat"
  #     expect(product.orders.last.name).must_equal "boo"
  #   end
    
  #   it "can have zero orders" do
  #     product3 = products(:product3)
      
  #     expect(product3.orders.length).must_equal 0
  #   end
  end
end
