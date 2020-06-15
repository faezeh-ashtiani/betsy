class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items

  validates :name, presence: true
  validates :credit_card, presence: true, length: { is: 16 }
  validates :status, presence: true, inclusion: { in: ["paid", "complete"] }


  def self.order_total(order_items) 
    total = 0.0
    order_items.each do |prod, val|
      total += (prod.price * val)
    end 
    return total + (total*(0.1))
  end 



end
