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


  describe "order_items relations" do
  
    let(:order_item) { order_items(:order_item1) }
  
    it "product has many order items" do 
      expect(order_item.product.name).must_equal "Mask"
    end
    
  end
  

  describe "order relations" do
  
    it 'order has product through order item' do
      order = orders(:order1)
      product1 = products(:product1)
    
      order.order_items.each do |item|
        expect(item.product_id).must_equal product1.id
      end

    end
  end

  describe "custome methods" do
    
    describe "average rating" do
      it "can calculate the average rating for a product with many ratings" do
        Review.create(rating: 3, description: "great", product_id: products(:product1).id)
        Review.create(rating: 4, description: "ok", product_id: products(:product1).id)

        expect(products(:product1).average_rating).must_equal 3.5
      end

      it "average rating of a product with no review is zero" do
        expect(products(:product1).average_rating).must_equal 0
      end
    end

  end

end
