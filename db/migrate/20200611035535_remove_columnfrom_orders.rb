class RemoveColumnfromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :qty
  end
end
