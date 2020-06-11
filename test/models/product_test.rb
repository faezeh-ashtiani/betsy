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


  # describe "order_items relations" do
  
  #   let(:order_item) { order_items(:order_item2) }
  
  #   it "product has an order item" do
  #     product = products(:product3)
  #     order_item.product_id = product.id
    
  #     expect(order_item.products.first.name).must_equal "marker"
  #   end
    
  
  # end

  # describe "order relations" do
  
  #   it 'set order product_id through product' do

  #   order1 = orders(:order1)
  #   product1 = products(:product1)
  #   order1.product_id = product1.id

  #   expect(order1.products).must_equal product1
      
  #   end
  # end
end
