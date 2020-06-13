require "test_helper"

describe Category do
  describe "relations" do
  end

  describe "validations" do
    let (:category) {
      Category.new(
        name: "Essentials",
      )
    }

    it "is valid for a category with all required fields" do
      expect(category.valid?).must_equal true
    end 

    it "has the required fields" do
      category.save
      new_category = Category.last
    
      [:name].each do |field|
        expect(new_category).must_respond_to field
      end
    end

    it "is invalid without a name" do
      category.name = nil
      
      expect(category.valid?).must_equal false
      expect(category.errors.messages).must_include :name
    end
  end
end
