class OrderItem < ApplicationRecord

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
      puts "THIS IS PRODUCT ID #{product_id}"
      session.each do |item|
        if product_id != item["product_id"]
          updated_cart << item 
        end 
      end
      puts "THIS IS SESSION 3 #{updated_cart}"
      return updated_cart
    end 
  
end
