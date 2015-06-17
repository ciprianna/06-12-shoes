# Location Class

class Location

  attr_reader :id
  attr_accessor :name

  # Assigns an id for identification in instance methods
  #
  # id (optional) - Integer assigned as the primary key
  # name (optional) - String
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
    DATABASE.execute("INSERT INTO locations (name) VALUES ('#{location_name}');")

    temp_id = DATABASE.last_insert_row_id

    object = Location.new(temp_id, location_name)

    return object
  end

  # Adds a Location Object to the locations table
  #
  # Returns id of Object if created - Integer, else returns false
  def add_to_database
    if Valid.name?
      DATABASE.execute("INSERT INTO locations (name) VALUES ('#{@name}');")

      @id = DATABASE.last_insert_row_id
    else
      return false
    end
  end

  # Locates a row from the locations table for the passed id.
  #
  # id - primary key; Integer
  #
  # Returns Location object
  def self.find(id)
    @id = id

    results = DATABASE.execute("SELECT * FROM locations WHERE id = #{@id};").first

    object = Location.new(id, results['name'])

    return object
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

    return store_results
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
      store_results << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end

    return store_results
  end

  # Update method for the locations table
  #
  # Returns true/false Boolean
  def save
    if Valid.name?
      DATABASE.execute("UPDATE locations SET name = '#{@name}' WHERE id = #{@id};")
    else
      return false
    end
  end

  # Delete a category row from the categories table
  #
  # Returns true/false Boolean
  def delete
    if self.shoes.empty?
      DATABASE.execute("DELETE FROM locations WHERE id = #{@id};")
    else
      return false
    end
  end

end
