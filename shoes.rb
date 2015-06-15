# Shoe Class

class Shoe

  # Assigns an id for identification in instance methods
  def initialize(id)
    @id = id
  end

  # Creates a new shoe (row) in the shoes table
  #
  # shoe_name - String
  # cost - Integer
  # color - String
  #
  # Returns nothing
  def self.add(shoe_name, cost, color, category_id, location_id, quantity)
    DATABASE.execute("INSERT INTO shoes (name, cost, color, category_id, location_id, location_stock) VALUES ('#{shoe_name}', #{cost}, '#{color}', '#{category_id}', '#{location_id}', #{quantity});")
  end

  # Read method for the shoes table
  #
  # Returns all data from the shoes table
  def self.all
    DATABASE.execute("SELECT * FROM shoes;")
  end

  # Read method for a single shoe product (row) in the shoes table
  #
  # Returns row of information
  def information
    DATABASE.execute("SELECT * FROM shoes WHERE id = #{@id};")
  end

  # Read method for stock quantities
  #
  # Returns products and quantity
  def self.quantity
    DATABASE.execute("SELECT id, name, location_stock FROM shoes;")
  end

  # Sums all of the product inventory
  #
  # Returns the total inventory - Integer
  def self.total_stock
    DATABASE.execute("SELECT SUM(location_stock) FROM shoes;")
  end

  # Shows all products by cost categories
  #
  # cost_category - String, should be categories of high, medium, or low
  #
  # Returns products within the given range
  def self.where_cost(cost_category)
    if cost_category == "high"
      DATABASE.execute("SELECT * FROM shoes WHERE cost >= 100")
    elsif cost_category == "medium"
      DATABASE.execute("SELECT * FROM shoes WHERE cost >= 50 AND cost < 100")
    else
      DATABASE.execute("SELECT * FROM shoes WHERE cost < 50")
    end
  end

  # Update any value for a given field that takes Strings
  #
  # field_name - String
  # new_value - String
  #
  # Returns nothing
  def update_strings(field_name, new_value)
    DATABASE.execute("UPDATE shoes SET #{field_name} = '#{new_value}' WHERE id = #{@id};")
  end

  # Update any value for a given field that takes Integers
  #
  # field_name - String
  # new_value - Integer
  #
  # Returns nothing
  def update_integers(field_name, new_value)
    DATABASE.execute("UPDATE shoes SET #{field_name} = #{new_value} WHERE id = #{@id};")
  end

  # Updates the name value in the shoes table
  #
  # new_name - String
  #
  # Returns nothing
  def update_name(new_name)
    update_strings("name", new_name)
  end

  # Updates the cost value in the shoes table
  #
  # new_cost - Integer
  #
  # Returns nothing
  def update_cost(new_cost)
    update_integers("cost", new_cost)
  end

  # Updates the color value in the shoes table
  #
  # new_color - String
  #
  # Returns nothing
  def update_color(new_color)
    update_strings("color", new_color)
  end

  # Assigns/updates the location_id of a shoe instance
  #
  # new_location_id - Integer
  #
  # Returns nothing
  def update_location(new_location_id)
    update_integers("location_id", new_location_id)
  end

  # Updates the quantity of a product for a given id
  #
  # to_add - Integer
  #
  # Returns nothing
  def update_quantity(to_add)
    current_quantity = DATABASE.execute("SELECT location_stock FROM shoes WHERE id = #{@id};").first['location_stock']
    DATABASE.execute("UPDATE shoes SET location_stock = #{current_quantity + to_add} WHERE id = #{@id};")
  end

  # Assigns/updates the category_id of a shoe instance
  #
  # new_category_id - Integer
  #
  # Returns nothing
  def update_category(new_category_id)
    update_integers("category_id", new_category_id)
  end

  # Deletes a shoe row from the shoes table
  #
  # Returns nothing
  def delete
    DATABASE.execute("DELETE FROM shoes WHERE id = #{@id};")
  end

end
