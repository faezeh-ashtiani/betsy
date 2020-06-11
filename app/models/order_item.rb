class OrderItem < ApplicationRecord

    def self.unique_items(order_items) 

      unique_items = {}
      
      order_items.each do |item|
        puts "THISSS item #{item}"
        qty = item["qty"]

        product = Product.find_by(id: item["product_id"])

        if unique_items[product] 
          unique_items[product] += qty
        else
          unique_items[product] = qty
        end 
      end 
      puts "THIS IS UNIQUE ITEMS : " + unique_items.to_s
      return unique_items 
    end 
  
end
