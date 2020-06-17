class Merchant < ApplicationRecord
  has_many :products
  validates :username, presence: true, uniqueness: { scope: :provider }
  validates :email, presence: true, uniqueness: { scope: :provider }
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true

  def self.create_merchant_from_github(auth_hash)
    merchant = Merchant.new
    merchant.uid = auth_hash["uid"]
    merchant.provider = auth_hash["provider"]
    # workaround for Github users that don't have their name shared
    if !auth_hash["info"]["name"].nil? 
      merchant.username = auth_hash["info"]["name"]
    elsif !auth_hash["info"]["nickname"].nil? 
      merchant.username = auth_hash["info"]["nickname"]
    else
      merchant.email = auth_hash["info"]["email"]
    end
    merchant.email = auth_hash["info"]["email"]

    return merchant
  end


  def get_all_orders
    order_ids = []

    self.products.each do |product|   
      product.order_items.each do |item|
        order_ids << item.order_id
      end
    end

    orders = order_ids.map{ |order_id|
      Order.find_by(id: order_id)
    }
  end 

  def get_orders_by_status(status)
    all_orders = self.get_all_orders
   
    return all_orders.select {|order| order.status == status}
  end

  def find_my_order_items(order)
    all_order_items = []

    order.order_items.each do |item|
      all_order_items << OrderItem.find_by(id: item.id)
    end 

    return all_order_items.select {|item| item.product.merchant_id == self.id}
  end 

  # calculate revenue of all orders with status "complete"

  # calculate revenue of all orders with status "paid"

  # total revenue 

end
