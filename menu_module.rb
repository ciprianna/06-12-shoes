# Module for Menu Items
module Menu

  # Main menu in ux to get an initial choice from the user
  #
  # Returns choice - Integer
  def self.main
    60.times {print "-"}
    puts "\n"
    puts "What would you like to do with the Cutesie Bootsie Inventory?"
    60.times {print "-"}
    puts "\n"
    puts "1".ljust(10) + "View current stock".rjust(30)
    puts "2".ljust(10) + "View quantity information".rjust(30)
    puts "3".ljust(10) + "Add new product".rjust(30)
    puts "4".ljust(10) + "Update product information".rjust(30)
    puts "5".ljust(10) + "View products by cost".rjust(30)
    puts "6".ljust(10) + "View location information".rjust(30)
    puts "7".ljust(10) + "View category information".rjust(30)
    puts "8".ljust(10) + "Delete product".rjust(30)
    puts "0".ljust(10) + "Exit Cutesie Bootsie Inventory".rjust(30)

    print ">> "
    choice = gets.to_i

    range = [1, 2, 3, 4, 5, 6, 7, 8, 0]

    Valid.response_check(range, choice)

    return choice

  end

  # Sub-Menu for tasks related to product quantity
  #
  # Returns quantity_choice - Integer
  def self.quantity
    40.times {print "-"}
    puts "\n"
    puts "What would you like to do?"
    40.times {print "-"}
    puts "\n"
    puts "1".ljust(10) + "View all stock quantities".rjust(30)
    puts "2".ljust(10) + "View low quantities".rjust(30)
    puts "3".ljust(10) + "Update stock quantities".rjust(30)
    puts "0".ljust(10) + "Exit quantity information".rjust(30)
    print ">> "
    quantity_choice = gets.to_i

    quantity_choice_range = [0, 1, 2, 3]

    Valid.response_check(quantity_choice_range, quantity_choice)

    return quantity_choice
  end

  # Sub-Menu for tasks relating to updating a product
  #
  # Returns to_update - Integer, menu selection
  def self.update_product
    40.times {print "-"}
    puts "\n"
    puts "1".ljust(10) + "Name".rjust(30)
    puts "2".ljust(10) + "Cost".rjust(30)
    puts "3".ljust(10) + "Color".rjust(30)
    puts "4".ljust(10) + "Category".rjust(30)
    puts "5".ljust(10) + "Location".rjust(30)
    puts "0".ljust(10) + "Exit product update".rjust(30)
    print ">> "
    to_update = gets.to_i

    range_for_updates = [0, 1, 2, 3, 4, 5]

    Valid.response_check(range_for_updates, to_update)

    return to_update
  end

  # Sub-Menu for location-related tasks to select.
  #
  # Returns location_choice - Integer
  def self.locations
    40.times {print "-"}
    puts "\n"
    puts "What would you like to do?"
    40.times {print "-"}
    puts "\n"
    puts "1".ljust(10) + "View all locations".rjust(30)
    puts "2".ljust(10) + "View all products at a location".rjust(30)
    puts "3".ljust(10) + "Change location name".rjust(30)
    puts "4".ljust(10) + "Add new location".rjust(30)
    puts "5".ljust(10) + "Delete location".rjust(30)
    puts "0".ljust(10) + "Exit location information".rjust(30)
    print ">> "
    location_choice = gets.to_i

    range_for_locations = [0, 1, 2, 3, 4, 5]

    Valid.response_check(range_for_locations, location_choice)

    return location_choice
  end

  def self.categories
    40.times {print "-"}
    puts "\n"
    puts "What would you like to do?"
    40.times {print "-"}
    puts "\n"
    puts "1".ljust(10) + "View all categories".rjust(30)
    puts "2".ljust(10) + "View all products in a category".rjust(30)
    puts "3".ljust(10) + "Change category name".rjust(30)
    puts "4".ljust(10) + "Add new category".rjust(30)
    puts "5".ljust(10) + "Delete category".rjust(30)
    puts "0".ljust(10) + "Exit category information".rjust(30)
    print ">> "
    category_choice = gets.to_i

    range_for_categories = [0, 1, 2, 3, 4, 5]

    Valid.response_check(range_for_categories, category_choice)

    return category_choice
  end

  # Lists all Objects in a Class like a menu
  #
  # class_to_list - Class to use the .all method on
  #
  # Returns a String containing Object information
  def self.list_all(class_to_list)
    class_to_list.all.each do |object|
      puts "#{object.id} - #{object.name}"
    end
  end

  # Lists all Objects in a Class like a menu and stores the ids in an Array.
  #
  # class_to_list - Class to use the .all method on
  #
  # Returns the Array of id's - Integers
  def self.list_all_store_range(class_to_list)
    range = []
    class_to_list.all.each do |object|
      puts "#{object.id} - #{object.name}"
      range << object.id
    end
    return range
  end
end
