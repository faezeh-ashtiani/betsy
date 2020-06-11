class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order




  def self.unique_items(order_items) 

    unique_items = {}
    
    order_items.each do |item|
    
      qty = item["qty"]

      product = Product.find_by(id: item["product_id"])

        if unique_items[product] 
          unique_items[product] += qty
        else
          unique_items[product] = qty
        end
      end 
      return unique_items 
    
    end 

    def self.remove_from_cart(session, product_id)
      updated_cart =  []
      session.each do |item|
        if product_id.to_i != item["product_id"].to_i
          updated_cart << item 
        end 
      end
      return updated_cart
    end 

 
end
