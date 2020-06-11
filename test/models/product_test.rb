require "test_helper"

describe Product do

  describe "relations" do
    it "can have reviews" do
      mask = products(:product1)

      review = reviews(:review1)
      review.product_id = mask.id
      expect(review.product_id).must_equal mask.id
    end

    it "has category/s" do
      mask = products(:product1)
      expect(mask.category_ids).must_be_kind_of Array

      # mask.category_ids.each do |category|
      #   cat = Category.where(category_id: category)
      #   expect(cat).must_be_kind_of Category
      # end
    end

   
  end
end
