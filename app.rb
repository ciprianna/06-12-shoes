# Driver
require "sqlite3"
require_relative "menu_module.rb"
require_relative "validity_module.rb"
require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"
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

################################################################################

# Main menu in ux to get an initial choice from the user
choice = Menu.main

# Begins the loop when a correct input from the user has been entered.
#   If zero, it skips the loop entirely and exits the program.
while choice != 0

##### Displays all products-----------------------------------------------------
  if choice == 1
    Shoe.all.each do |shoe_object|
      puts "ID: #{shoe_object.id}, Name: #{shoe_object.name}, Cost: #{shoe_object.cost}, Color: #{shoe_object.color}, Category: #{shoe_object.category_id}, Location: #{shoe_object.location_id}, Quantity: #{shoe_object.location_stock}"
    end
  end
##### Quantity information menu; gives a list of sub-options--------------------
  if choice == 2
    quantity_choice = Menu.quantity

    while quantity_choice != 0

      ##### Views all stock quantities------------------------------------------
      if quantity_choice == 1
        Shoe.all.each do |shoe_object|
          puts "#{shoe_object.id} - #{shoe_object.name} (#{shoe_object.location_stock})"
        end

        puts "Total stock quantity - #{Shoe.total_stock}"
      end

      ##### Shows all items where_quantity_is_low-------------------------------
      if quantity_choice == 2
        Shoe.where_quantity_is_low.each do |shoe_object|
          puts "#{shoe_object.id} - #{shoe_object.name} (#{shoe_object.location_stock})"
        end
      end

      ##### Updates an item's quantity------------------------------------------
      if quantity_choice == 3
        puts "Which product quantity would you like to update?"
        quantity_range = Menu.list_all_store_range(Shoe)
        print ">> "
        shoe_to_change = gets.to_i

        shoe_to_change = Valid.response_check(quantity_range, shoe_to_change)

        shoe = Shoe.find(shoe_to_change)

        puts "Okay, and how many are you adding? If removing quantity, enter a negative number."
        print ">> "
        change = gets.to_i

        shoe.update_quantity(change)
        if shoe.save_valid
          puts "Quantity updated"
        else
          puts "Quantity update failed."
        end
      end

      ##### Re-asks for the menu options----------------------------------------
      quantity_choice = Menu.quantity

    end
  end

##### Adds a new item to the inventory------------------------------------------
  if choice == 3
    puts "Okay, there's a new shoe to add to the inventory. Press anything to continue or type '0' to exit."
    continue = gets.chomp

    while continue != '0'
      new_shoe_object = Shoe.new
      puts "Shoe name:"
      print ">> "
      new_shoe_object.name = gets.chomp
      puts "Cost:"
      print ">> "
      new_shoe_object.cost = gets.to_f
      puts "Color:"
      print ">> "
      new_shoe_object.color = gets.chomp
      puts "Category:"
      category_range = Menu.list_all_store_range(Category)
      print ">> "
      category_id = gets.to_i

      new_shoe_object.category_id = Valid.response_check(category_range, category_id)

      puts "Storage location:"
      location_range = Menu.list_all_store_range(Location)
      print ">> "
      location_id = gets.to_i

      new_shoe_object.location_id = Valid.response_check(location_range, location_id)

      puts "Quantity:"
      print ">> "
      new_shoe_object.location_stock = gets.to_i

      if new_shoe_object.add_to_database
        puts "Product added to inventory."
      else
        puts "Product could not be added - Missing Information."
      end

      puts "Press anything to add another new shoe to the Inventory. Otherwise, type '0' to exit."
      continue = gets.chomp
    end
  end

##### Updates a product's information-------------------------------------------
  if choice == 4
    puts "Which product would you like to update?"
    shoe_range = Menu.list_all_store_range(Shoe)
    print ">> "
    shoe = gets.to_i

    shoe = Valid.response_check(shoe_range, shoe)

    shoe_to_change = Shoe.find(shoe)

    ##### Displays all information pertaining to the selected shoe--------------
    puts "ID: #{shoe_to_change.id}, Name: #{shoe_to_change.name}, Cost: #{shoe_to_change.cost}, Color: #{shoe_to_change.color}, Category: #{shoe_to_change.category_id}, Location: #{shoe_to_change.location_id}, Quantity: #{shoe_to_change.location_stock}"

    ##### Sub-menu for updating-------------------------------------------------
    40.times {print "-"}
    puts "\n"
    puts "What would you like to update?"
    to_update = Menu.update_product

    ##### Begins loop once a valid input is entered; if zero, exits the sub-menu
    while to_update != 0

      ##### Updates the name of the shoe----------------------------------------
      if to_update == 1
        puts "What is the new name for this shoe?"
        print ">> "
        new_name = gets.chomp
        shoe_to_change.name = new_name
      end

      ##### Updates the cost of the shoe----------------------------------------
      if to_update == 2
        puts "What is the new cost for this shoe?"
        print ">> "
        new_cost = gets.to_f
        shoe_to_change.cost = new_cost
      end

      ##### Updates the color of the shoe---------------------------------------
      if to_update == 3
        puts "What is the new color of the shoe?"
        print ">> "
        new_color = gets.chomp
        shoe_to_change.color = new_color
      end

      ##### Updates the category_id of the shoe---------------------------------
      if to_update == 4
        puts "What is the new category of the shoe?"
        category_range = Menu.list_all_store_range(Category)
        print ">> "
        new_category_id = gets.to_i

        new_category_id = Valid.response_check(category_range, new_category_id)

        shoe_to_change.category_id = new_category_id
      end

      ##### Updates the location_id of the shoe---------------------------------
      if to_update == 5
        puts "What location is this shoe moving to?"
        location_range = Menu.list_all_store_range(Location)
        print ">> "
        new_location_id = gets.to_i

        new_location_id = Valid.response_check(locaiton_range, new_location_id)

        shoe_to_change.location_id = new_location_id
      end

      ##### Re-asks what option the user would like to choose-------------------
      40.times {print "-"}
      puts "\n"
      puts "Is there anything else to update for this product?"

      to_update = Menu.update_product

    end

    if shoe_to_change.save_valid
      puts "Product update successful."
    else
      puts "Product update failed to save."
    end

  end

##### Displays information by pricing category----------------------------------
  if choice == 5
    puts "Which pricing category would you like to see?"
    puts "High - $100+"
    puts "Medium - $50-$99"
    puts "Low - $0-$49"
    print ">> "
    pricing_category = gets.chomp.downcase

    while (pricing_category != "high") && (pricing_category != "medium") && (pricing_category != "low")
      puts "Please select 'high', 'medium', or 'low':"
      print ">> "
      pricing_category = gets.chomp.downcase
    end

    shoes_by_price = Shoe.where_cost(pricing_category)
    shoes_by_price.each do |shoe|
      puts "ID: #{shoe.id}, Name: #{shoe.name}, Cost: #{shoe.cost}, Color: #{shoe.color}, Category: #{shoe.category_id}, Location: #{shoe.location_id}, Quantity: #{shoe.location_stock}"
    end
  end

##### Displays options for the locations menu-----------------------------------
  if choice == 6
    location_choice = Menu.locations

    ##### Begins loop once a valid input is entered; if zero, exits the sub-menu
    while location_choice != 0

      ##### Displays all locations----------------------------------------------
      if location_choice == 1
        puts "Locations:"
        Menu.list_all(Location)
      end

      ##### Displays all products at an instance of a location------------------
      if location_choice == 2
        puts "Which location would you like to view products at?"
        location_range = Menu.list_all_store_range(Location)
        print ">> "
        location = gets.to_i

        location = Valid.response_check(location_range, location)

        location_to_view = Location.find(location)

        location_to_view.shoes.each do |shoes|
          puts "#{shoes.id} - #{shoes.name} (#{shoes.location_stock})"
        end

      end

      ##### Changes the name of a location--------------------------------------
      if location_choice == 3
        puts "Which location would you like to change the name of?"
        location_range = Menu.list_all_store_range(Location)
        print ">> "
        location = gets.to_i

        location = Valid.response_check(location_range, location)

        location_to_change = Location.find(location)

        puts "What is the new name of this location?"
        print ">> "
        new_location_name = gets.chomp

        location_to_change.name = new_location_name

        if location_to_change.save_valid
          puts "Location name changed."
        else
          puts "Name change failed."
        end
      end

      ##### Adds a new location-------------------------------------------------
      if location_choice == 4
        puts "What's the name of the new location?"
        print ">> "
        new_location = gets.chomp
        location_to_add = Location.new
        location_to_add.name = new_location

        if location_to_add.add_to_database
          puts "Location added."
        else
          puts "Failed to add location."
        end
      end

      ##### Deletes a location, after checking to ensure nothing is stored there
      if location_choice == 5
        puts "Which location would you like to delete?"
        location_range = Menu.list_all_store_range(Location)
        print ">> "
        location = gets.to_i

        location = Valid.response_check(location_range, location)

        location_to_delete = Location.find(location)

        if location_to_delete.delete_location
          puts "Location deleted"
        else
          puts "Cannot delete this location while shoes are stored here."
          location_to_delete.shoes.each do |shoes|
            puts "#{shoes.id} - #{shoes.name} (#{shoes.location_stock})"
          end
        end

      end

      ##### Re-asks the user to input an option---------------------------------
      location_choice = Menu.locations

    end

  end

##### Displays the options in the Category Menu---------------------------------
  if choice == 7
    category_choice = Menu.categories

    ##### Begins loop once a valid input is entered; if zero, exits the sub-menu
    while category_choice != 0

      ##### Displays all categories---------------------------------------------
      if category_choice == 1
        puts "Categories:"
        Menu.list_all(Category)
      end

      ##### Displays all products in a category instance------------------------
      if category_choice == 2
        puts "Which category would you like to view products in?"
        category_range = Menu.list_all_store_range(Category)
        print ">> "
        category = gets.to_i

        category = Valid.response_check(category_range, category)

        category_to_view = Category.find(category)
        category_to_view.shoes.each do |shoes|
          puts "#{shoes.id} - #{shoes.name} (#{shoes.location_stock})"
        end
      end

      ##### Changes the name of a category--------------------------------------
      if category_choice == 3
        puts "Which category would you like to change the name of?"
        category_range = Menu.list_all_store_range(Category)
        print ">> "
        category = gets.to_i

        category = Valid.response_check(category_range, category)

        category_to_change = Category.find(category)

        puts "What is the new name of this category?"
        print ">> "
        new_category_name = gets.chomp

        category_to_change.name = new_category_name

        if category_to_change.save_valid
          puts "Category name changed."
        else
          puts "Name change failed."
        end
      end

      ##### Adds a new category-------------------------------------------------
      if category_choice == 4
        puts "What's the name of the new category?"
        print ">> "
        new_category = gets.chomp
        category_to_add = Category.new
        category_to_add.name = new_category

        if category_to_add.add_to_database
          puts "Category added."
        else
          puts "Failed to add category."
        end
      end

      ##### Deletes a category after checking to ensure no products are assigned
      #####   to that category--------------------------------------------------
      if category_choice == 5
        puts "Which category would you like to delete?"
        category_range = Menu.list_all_store_range(Category)
        print ">> "
        category = gets.to_i

        category = Valid.response_check(category_range, category)

        category_to_delete = Category.find(category)

        if category_to_delete.delete_category
          puts "Category deleted"
        else
          puts "Cannot delete this category while shoes are assigned."
          category_to_delete.shoes.each do |shoes|
            puts "#{shoes.id} - #{shoes.name} (#{shoes.location_stock})"
          end
        end
      end

      ##### Re-asks the user for an option--------------------------------------
      category_choice = Menu.categories

    end

  end

##### Deletes a product from the inventory--------------------------------------
  if choice == 8
    puts "Which product would you like to delete?"
    shoe_range = Menu.list_all_store_range(Shoe)
    print ">> "
    shoe_choice = gets.to_i

    shoe_choice = Valid.response_check(shoe_range, shoe_choice)

    shoe_to_delete = Shoe.find(shoe_choice)

    puts "ID: #{shoe_to_delete.id}, Name: #{shoe_to_delete.name}, Cost: #{shoe_to_delete.cost}, Color: #{shoe_to_delete.color}, Category: #{shoe_to_delete.category_id}, Location: #{shoe_to_delete.location_id}, Quantity: #{shoe_to_delete.location_stock}"

    puts "Are you sure you wish to delete this product? (yes/no)"
    print ">> "
    sure = gets.chomp.downcase

    if sure == "yes"
      if shoe_to_delete.delete
        puts "Shoe successfully deleted."
      else
        puts "Deletion failed."
      end
    end

  end

##### Re-asks the user for an option--------------------------------------------
  choice = Menu.main

end

##### Exit menu message---------------------------------------------
puts "Bye!"
