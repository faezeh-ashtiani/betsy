require "test_helper"

describe Review do
  describe "relations" do

    it "has an product" do
      review = reviews(:review1)
      expect(review).must_respond_to :product
      product = products(:product1)
      review.product_id = product.id
      expect(review.product).must_be_kind_of Product
      
    end

   
  end
end
