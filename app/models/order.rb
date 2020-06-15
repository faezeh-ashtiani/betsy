class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items

  validates :name, presence: true
  validates :credit_card, presence: true, length: { is: 16 }
  #validates :status, presence: true, inclusion: { in: ["paid", "complete"] }




end
