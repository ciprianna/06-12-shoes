# Location Class
require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

class Location
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name

  # Assigns an id for identification in instance methods
  #
  # options - Empty Hash
  #   - id (optional) - Integer assigned as the primary key
  #   - name (optional) - String
  #
  # Returns newly created Location Object
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
  end

  # Adds a Location Object to the locations table
  #
  # Returns Location Object, else returns false
  def add_to_database
    if Valid.name?(self)
      self.add
    else
      return false
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
      store_results << Shoe.new(hash)
    end

    return store_results
  end

  # Update method for the locations table
  #
  # Returns true/false Boolean
  def save_valid
    if Valid.name?(self)
      self.save
    else
      return false
    end
  end

  # Delete a category row from the categories table
  #
  # Returns true/false Boolean
  def delete_location
    if self.shoes.empty?
      self.delete
    else
      return false
    end
  end

end
