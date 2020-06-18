class OrderStatus
  def self.all 
    return ["paid", "complete"]
  end 

  def self.optional_all
    return all.insert(0, "all")
  end 
end 