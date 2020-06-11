require "test_helper"

describe Product do
  describe "relations" do
    it "can have reviews" do
      mask = products(:product1)

      review = Review.create!(rating: 4, description: 'awesome', product_id: mask.id)
      expect(mask.review).must_be_kind_of review
    end

    it "has category/s" do
      mask = products(:product1)
      expect(mask.category_ids).must_be_kind_of Array

      mask.category_ids.each do |category|
        expect(category).must_be_kind_of category
      end
    end

    # it "has a list of ranked works" do
    #   dan = users(:dan)
    #   expect(dan).must_respond_to :ranked_works
    #   dan.ranked_works.each do |work|
    #     expect(work).must_be_kind_of Work
    #   end
   
  end
end
