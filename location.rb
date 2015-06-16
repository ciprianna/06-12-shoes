# Location Class

class Location

  # Assigns an id for identification in instance methods
  #
  # id - Integer assigned as the primary key
  # name - String
  #
  # Returns newly created Location Object
  def initialize(id = nil, name = nil)
    @id = id
    @name = name
  end

  # Creates a new location (row) in the locations table
  #
  # location_name - String
  #
  # Returns the newly created Location Object
  def self.add(location_name)
    results = DATABASE.execute("INSERT INTO locations (name) VALUES ('#{location_name}');").first

    temp_id = DATABASE.last_insert_row_id

    Location.new(temp_id, results['location_name'])
  end

  # Read method for the locations table
  #
  # Returns all information from the locations table as an Array of Location
  #   Objects.
  def self.all
    results = DATABASE.execute("SELECT * FROM locations;")

    store_results = []

    results.each do |hash|
      store_results << Location.new(hash['id'], hash['name'])
    end
  end

  # Reads all shoes at a location object
  #
  # Returns all shoe information at one location from the shoes table as an
  #   Array of Objects. Each Object corresponds to a row of data which is stored
  #   at the passed id.
  def shoes
    results = DATABASE.execute("SELECT * FROM shoes WHERE location_id = #{@id};")

    store_results = []

    results.each do |hash|
      store_results << Location.new(hash['id'], hash['name'])
    end
  end

  # Update method for the locations table
  #
  # Returns the newly updated row as a Location Object
  def save
    result = DATABASE.execute("UPDATE locations SET name = '#{@name}' WHERE id = #{@id};").first

    Location.new(result['id'], result['name'])
  end

  # Checks to see if the location contains no products.
  #
  # Returns true or false - Binary
  def empty?
    self.shoes == []
  end

  # Delete a category from the categories table
  #
  # Returns the remaining rows as an Array of Location Objects
  def delete
    if self.empty?
      results = DATABASE.execute("DELETE FROM locations WHERE id = #{@id};")

      store_results = []

      results.each do |hash|
        store_results << Location.new(hash['id'], hash['name'])
      end
    end
  end

end
