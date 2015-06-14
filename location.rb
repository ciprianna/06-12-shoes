# Location Class

class Location

  # Assigns an id for identification in instance methods
  def initialize(id)
    @id = id
  end

  # Creates a new location (row) in the locations table
  #
  # location_name - String
  #
  # Returns nothing
  def self.add(location_name)
    DATABASE.execute("INSERT INTO locations (name) VALUES ('#{location_name}');")
  end

  # Read method for the locations table
  #
  # Returns all data from the locations table
  def self.all
    DATABASE.execute("SELECT * FROM locations;")
  end

  # Reads all shoes at a location object
  #
  # Returns all shoes (rows) at that location from the shoes table
  def shoes
    DATABASE.execute("SELECT * FROM shoes WHERE id = #{@id};")
  end

  # Update method for the locations table
  #
  # new_location_name - String
  #
  # Returns nothing
  def update(new_location_name)
    DATABASE.execute("UPDATE locations SET name = '#{new_location_name}' WHERE id = #{@id};")
  end

  # Delete a category from the categories table
  #
  # Returns nothing
  def delete
    # INSERT check for current items of said category
    DATABASE.execute("DELETE FROM locations WHERE id = #{@id}")
  end

end
