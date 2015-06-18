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

  # Adds a Category Object to the categories table
  #
  # Returns Category Object if created, else returns false
  def add_to_database
    if Valid.name?(self)
      self.add
    else
      return false
    end
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

  # # Update method for the categories table
  # #
  # # Returns true/false Boolean
  # def save
  #   if Valid.name?(self)
  #     DATABASE.execute("UPDATE categories SET name = '#{@name}' WHERE id = #{@id};")
  #   else
  #     return false
  #   end
  # end

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
