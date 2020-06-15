class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items

  validates :name, presence: true
  validates :credit_card, presence: true, length: { is: 16 }
  #validates :status, presence: true, inclusion: { in: ["paid", "complete"] }


  def self.update_qty_from_order(products)
    products.each do |product|
      current = Product.find_by(id: product.product_id)
      current.qty = (current.qty - product.qty)
      current.reload
    end 
  end 


end
