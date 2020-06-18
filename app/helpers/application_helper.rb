module ApplicationHelper

  def format_currency(price)
    format('$%<price>.2f', price: price)
  end
  
end
