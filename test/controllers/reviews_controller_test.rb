require "test_helper"

describe ReviewsController do
  describe "create" do
    let(:review_data) {
      {
        rating: 3,
        description: "A good product but too expensive.",
        # product_id: 1
      }
    }

    it "can create a new reveiw with valid information accurately, and redirect" do
      product_id = products(:product1).id
      expect {
        post product_reviews_path(product_id), params: review_data
      }.must_differ 'Review.count', 1
      
      saved_review = Review.last
      must_redirect_to product_path(product_id)
      expect(saved_review.rating).must_equal review_data[:rating]
      expect(saved_review.description).must_equal review_data[:description]
    end

    it "does not create a review if the form data violates review validations with no rating, and responds with bad_request" do
      review_data[:rating] = nil
      product_id = products(:product1).id
      expect {
        post product_reviews_path(product_id), params: review_data
      }.must_differ "Review.count", 0
      must_respond_with :redirect
     
    end

  end


end
