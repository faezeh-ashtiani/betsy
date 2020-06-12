class Product < ApplicationRecord
  has_many :reviews
  has_many :order_items
  has_and_belongs_to_many :categories
  has_many :orders, through: :order_items

  def average_rating
    if self.reviews.length == 0
      return 0
    else
      (self.reviews.sum { |review| review.rating.to_f } / self.reviews.length).round(2)
    end
  end

  protected 


end
