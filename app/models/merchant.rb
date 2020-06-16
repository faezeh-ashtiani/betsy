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
      user.username = auth_hash["info"]["name"]
    elsif !auth_hash["info"]["nickname"].nil? 
      user.username = auth_hash["info"]["nickname"]
    else
      user.username = user.email = auth_hash["info"]["email"]
    end
    merchant.email = auth_hash["info"]["email"]

    return merchant
  end

end
