# Category Class
require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

class Category
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name

  # Assigns an id for identification in instance methods
  #
  # options - emtpy Hash
  #   - id (optional) - Integer assigned as the primary key from the id column
  #   - name (optional) - String
  #
  # Returns the category object created
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
  end

  # Creates a new category (row) in the categories table
  #
  # category_name - String
  #
  # Returns the new Category Object
  def self.add(category_name)
    DATABASE.execute("INSERT INTO categories (name) VALUES ('#{category_name}');")

    temp_id = DATABASE.last_insert_row_id

    object = Category.new(temp_id, category_name)

    return object
  end

  # Adds a Category Object to the categories table
  #
  # Returns id of Object if created - Integer, else returns false
  def add_to_database
    if Valid.name?(self)
      DATABASE.execute("INSERT INTO categories (name) VALUES ('#{@name}');")

      @id = DATABASE.last_insert_row_id
    else
      return false
    end
  end

  # Read method for the categories table
  #
  # Returns all data from the categories table as an Array of Category Objects.
  #   Each Object represents a row from the categories table.
  def self.all_as_objects
    results = self.all

    store_results = []

    results.each do |hash|
      store_results << Category.new(hash['id'], hash['name'])
    end

    return store_results
  end

  # Reads all shoes in a category object
  #
  # Returns all shoe information in a category from the shoes table as an Array
  #   of Shoe Objects. Each Object represents a row with the given category_id.
  def shoes
    results = DATABASE.execute("SELECT * FROM shoes WHERE category_id = #{@id};")

    store_results = []

    results.each do |hash|
      store_results << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end

    return store_results
  end

  # Update method for the categories table
  #
  # Returns true/false Boolean
  def save
    if Valid.name?(self)
      DATABASE.execute("UPDATE categories SET name = '#{@name}' WHERE id = #{@id};")
    else
      return false
    end
  end

  # Delete a category from the categories table
  #
  # Returns true/false Boolean
  def delete_category
    if self.shoes.empty?
      self.delete
    else
      return false
    end
  end

end
