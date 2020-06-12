require "test_helper"

describe MerchantsController do

  describe "merchant_products" do
    it "succeeds when there are products in a merchant" do
      merchant_id = merchants(:merchant1).id
      get merchant_products_path(merchant_id)
      must_respond_with :success
    end

    it "succeeds when there are no products" do
      Product.destroy_all
      merchant_id = merchants(:merchant1).id
      get merchant_products_path(merchant_id)

      must_respond_with :success
    end
  end

end
