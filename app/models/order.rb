class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items



  def check_out
    #call a method here that goes through all the order items and updates quantity 

  end 


end
