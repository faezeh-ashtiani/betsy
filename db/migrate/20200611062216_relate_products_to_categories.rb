class RelateProductsToCategories < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories, :product, index: true
  end
end
