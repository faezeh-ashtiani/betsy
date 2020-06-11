class RelateProductsToOrders2 < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :product, index: true
  end
end
