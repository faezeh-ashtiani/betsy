# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

MERCHANT_FILE = Rails.root.join('db', 'merchants_seeds.csv')
puts "Loading raw merchant data from #{MERCHANT_FILE}"

merchant_failures = []
CSV.foreach(MERCHANT_FILE, :headers => true) do |row|
  merchant = Merchant.new
  merchant.username = row['username']
  merchant.email = row['email']
  merchant.uid = row['uid']
  merchant.provider = row['provider']
  
  successful = merchant.save
  if !successful
    merchant_failures << merchant
    puts "Failed to save merchant: #{merchant.inspect}"
  else
    puts "Created merchant: #{merchant.inspect}"
  end
end

puts "Added #{Merchant.count} merchant records"
puts "#{merchant_failures.length} merchant failed to save"

PRODUCT_FILE = Rails.root.join('db', 'products_seeds.csv')
puts "Loading raw product data from #{PRODUCT_FILE}"

product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  if !Product.create!(id: row['id'] , name:row['name'] , price:row['price'].to_f , img_url: row['img_url'], description: row['description'], qty: row['qty'].to_i , merchant: Merchant.all.sample)
    product_failures << product
    puts "Failed to save product: "
  else
    puts "Created product"
  end
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} product failed to save"

CATEGORY_FILE = Rails.root.join('db', 'categories_seeds.csv')
puts "Loading raw product data from #{CATEGORY_FILE}"

category_failures = []
CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = Category.new
  category.id = row['id']
  category.name = row['name']
  successful = category.save
  if !successful
    category_failures << category
    puts "Failed to save category: #{category.inspect}"
  else
    puts "Created category: #{category.inspect}"
  end
end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} category failed to save"

Product.all.each do |product|
  product.categories.concat(Category.all.sample(3))
  product.save
end

# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
