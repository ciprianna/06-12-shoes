# Driver

require "sqlite3"
require_relative "shoes.rb"
require_relative "location.rb"
require_relative "category.rb"

# Creates the database connection
DATABASE = SQLite3::Database.new("shoe_inventory.db")

# Creates the table
DATABASE.execute("CREATE TABLE IF NOT EXISTS shoes (id INTEGER PRIMARY KEY, name TEXT NOT NULL, cost INTEGER NOT NULL, color TEXT NOT NULL, category_id INTEGER, location_id INTEGER, location_stock INTEGER);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, name TEXT);")
DATABASE.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, name TEXT);")

# Returns the results as a Hash
DATABASE.results_as_hash = true

##############################

puts "What would you like to do with the Cutsie Bootsie Inventory?"
puts 30.times "-"
puts "1".ljust(10) + "View current stock".rjust(20)
puts "2".ljust(10) + "View stock quantities".rjust(20)
puts "3".ljust(10) + "Update stock quantity".rjust(20)
puts "4".ljust(10) + "Update product information".rjust(20)
puts "5".ljust(10) + "View all products at a location".rjust(20)
puts "6".ljust(10) + "View all products in a category".rjust(20)
puts "7".ljust(10) + "Delete product".rjust(20)
puts "8".ljust(10) + "Exit".rjust(20)

choice = gets.to_i

range = [1..8]

while range.include?(choice) == false
  puts "Please choose a number from the menu"
  choice = gets.chomp
end

while choice != 8

  if choice == 1
    shoes.all
  end

  if choice == 2
  end

  puts "What would you like to do with the Cutsie Bootsie Inventory?"
  puts 30.times "-"
  puts "1".ljust(10) + "View current stock".rjust(20)
  puts "2".ljust(10) + "Update stock quantity".rjust(20)
  puts "3".ljust(10) + "Update product information".rjust(20)
  puts "4".ljust(10) + "View all products at a location".rjust(20)
  puts "5".ljust(10) + "View all products in a category".rjust(20)
  puts "6".ljust(10) + "Delete product".rjust(20)
  puts "7".ljust(10) + "Exit".rjust(20)

  choice = gets.to_i

end

puts "Bye!"
