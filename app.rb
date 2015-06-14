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

puts "What would you like to do with the Cutesie Bootsie Inventory?"
50.times do print "-" end
puts "\n"
puts "1".ljust(10) + "View current stock".rjust(30)
puts "2".ljust(10) + "Add new product".rjust(30)
puts "3".ljust(10) + "View stock quantities".rjust(30)
puts "4".ljust(10) + "Update stock quantity".rjust(30)
puts "5".ljust(10) + "Update product information".rjust(30)
puts "6".ljust(10) + "View location information".rjust(30)
puts "7".ljust(10) + "View category information".rjust(30)
puts "8".ljust(10) + "Delete product".rjust(30)
puts "0".ljust(10) + "Exit Cutesie Bootsie Inventory".rjust(30)

choice = gets.to_i

range = [1, 2, 3, 4, 5, 6, 7, 8, 0]

while range.include?(choice) == false
  puts "Please choose a number from the menu"
  choice = gets.chomp
end

while choice != 0

  if choice == 1
    Shoe.all
  end

  if choice == 2
    puts "Okay, please enter the product information."
    puts "Shoe name:"
    name = gets.chomp
    puts "Cost:"
    cost = gets.to_f
    puts "Color:"
    color = gets.chomp
    puts "Category:"
    Category.all.each do |category_hash|
      puts "#{category_hash['id']} - #{category_hash['name']}"
    end
    category_id = gets.to_i
    puts "Storage location:"
    Location.all.each do |location_hash|
      puts "#{location_hash['id']} - #{location_hash['name']}"
    end
    location_id = gets.to_i
    puts "Quantity:"
    quantity = gets.to_i
    Shoe.add(name, cost, color, category_id, location_id, quantity)
  end

  if choice == 3
    Shoe.quantity
  end

  if choice == 4
    puts "Which product quantity would you like to update?"
    Shoe.all.each do |shoe_hash|
      puts "#{shoe_hash['id']} - #{shoe_hash['name']}"
    end

    shoe_to_change = gets.to_i

    shoe = Shoe.new(shoe_to_change)

    puts "Okay, and how many are you adding? If removing quantity, enter a negative number."
    change = gets.to_i

    shoe.update_quantity(change)

  end

  if choice == 5
    puts "Which product would you like to update?"
    Shoe.all.each do |shoe_hash|
      puts "#{shoe_hash['id']} - #{shoe_hash['name']}"
    end
    shoe = gets.to_i
    shoe_to_change = Shoe.new

    puts "And what would you like to update?"
    puts "1".ljust(10) + "Name".rjust(30)
    puts "2".ljust(10) + "Cost".rjust(30)
    puts "3".ljust(10) + "Color".rjust(30)
    puts "4".ljust(10) + "Category".rjust(30)
    puts "5".ljust(10) + "Location".rjust(30)
    puts "0".ljust(10) + "Exit product update".rjust(30)
    to_update = gets.to_i

    while to_update != 0

      if to_update == 1
        "What is the new name for this shoe?"
        new_name(gets.chomp)
        shoe_to_change.update_name(new_name)
      end

      if to_update == 2
        "What is the new cost for this shoe?"
        new_cost = gets.to_f
        shoe_to_change.update_cost(new_cost)
      end

      if to_update == 3
        "What is the new color of the shoe?"
        new_color = gets.chomp
        shoe_to_change.update_color(new_color)
      end

      if to_update == 4
        puts "What is the new category of the shoe?"
        Category.all.each do |category_hash|
          puts "#{category_hash['id']} - #{category_hash['name']}"
        end
        new_category_id = gets.to_i
        shoe_to_change.update_category(new_category_id)
      end

      if to_update == 5
        puts "What location is this shoe moving to?"
        Location.all.each do |location_hash|
          puts "#{location_hash['id']} - #{location_hash['name']}"
        end
        new_location_id = gets.to_i
        shoe_to_change.update_location(new_location_id)
      end

      puts "Is there anything else to update for this product?"
      puts "1".ljust(10) + "Name".rjust(30)
      puts "2".ljust(10) + "Cost".rjust(30)
      puts "3".ljust(10) + "Color".rjust(30)
      puts "4".ljust(10) + "Category".rjust(30)
      puts "5".ljust(10) + "Location".rjust(30)
      puts "0".ljust(10) + "Exit product update".rjust(30)
      to_update = gets.to_i

    end

  end

  if choice == 6
    puts "What would you like to do?"
    puts "1".ljust(10) + "View all products at a location".rjust(30)
    puts "2".ljust(10) + "Change location name".rjust(30)
    puts "3".ljust(10) + "Add new location".rjust(30)
    puts "4".ljust(10) + "Delete location".rjust(30)
    puts "0".ljust(10) + "Exit location information".rjust(30)

    location_choice = gets.to_i

    while location_choice != 0

      if location_choice == 1
        puts "Which location would you like to view products at?"
        Location.all.each do |location_hash|
          puts "#{location_hash['id']} - #{location_hash['name']}"
        end
        location = gets.to_i
        location_to_view = Location.new
        location_to_view.shoes
      end

      if location_choice == 2
        puts "Which location would you like to change the name of?"
        Location.all.each do |location_hash|
          puts "#{location_hash['id']} - #{location_hash['name']}"
        end
        location = gets.to_i
        location_to_change = Location.new

        puts "What is the new name of this location?"
        new_location_name = gets.chomp

        location_to_change.update(new_location_name)
      end

      if location_choice == 3
        puts "What's the name of the new location?"
        new_location = gets.chomp
        Location.add(new_location)
      end

      if location_to_change == 4
        puts "Which location would you like to delete?"
        Location.all.each do |location_hash|
          puts "#{location_hash['id']} - #{location_hash['name']}"
        end
        location = gets.to_i
        location_to_delete = Location.new

        if location_to_delete.shoes.length != 0
          puts "Cannot delete this location while shoes are stored here."
          location_to_delete.shoes
        else
          location_to_delete.delete
        end

      end

      puts "What would you like to do?"
      puts "1".ljust(10) + "View all products at a location".rjust(30)
      puts "2".ljust(10) + "Change location name".rjust(30)
      puts "3".ljust(10) + "Add new location".rjust(30)
      puts "4".ljust(10) + "Delete location".rjust(30)
      puts "0".ljust(10) + "Exit location information".rjust(30)

      location_choice = gets.to_i

    end

  end

  if choice == 7
    puts "What would you like to do?"
    puts "1".ljust(10) + "View all products in a category".rjust(30)
    puts "2".ljust(10) + "Change category information".rjust(30)
    puts "3".ljust(10) + "Add new category".rjust(30)
    puts "4".ljust(10) + "Delete category".rjust(30)
    puts "0".ljust(10) + "Exit category information".rjust(30)
  end

  puts "What would you like to do with the Cutsie Bootsie Inventory?"
  50.times do print "-" end
  puts "\n"
  puts "1".ljust(10) + "View current stock".rjust(30)
  puts "2".ljust(10) + "Add new product".rjust(30)
  puts "3".ljust(10) + "View stock quantities".rjust(30)
  puts "4".ljust(10) + "Update stock quantity".rjust(30)
  puts "5".ljust(10) + "Update product information".rjust(30)
  puts "6".ljust(10) + "View location information".rjust(30)
  puts "7".ljust(10) + "View category information".rjust(30)
  puts "8".ljust(10) + "Delete product".rjust(30)
  puts "0".ljust(10) + "Exit Cutsie Bootsie Inventory".rjust(30)
  choice = gets.to_i

  while range.include?(choice) == false
    puts "Please choose a number from the menu"
    choice = gets.chomp
  end

end

puts "Bye!"
