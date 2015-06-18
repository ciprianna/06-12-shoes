# Shoe Class
require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

class Shoe
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :name, :cost, :color, :category_id, :location_id, :location_stock

  # Assigns an id for identification in instance methods
  #
  # id (optional) - Integer assigned as the primary key from the id column
  # name (optional) - String that is the shoe's name
  # cost (optional) - Integer that represents the cost of the shoe
  # color (optional) - String for the color of the shoe
  # category_id (optional) - Integer, foreign key from the categories table
  # location_id (optional) - Integer, foreign key from the locations table
  # location_stock (optional) - Integer indicating quantity of product
  #
  # Returns Shoe object created
  def initialize(id = nil, name = nil, cost = nil, color = nil, category_id = nil, location_id = nil, location_stock = nil)
    @id = id
    @name = name
    @cost = cost
    @color = color
    @category_id = category_id
    @location_id = location_id
    @location_stock = location_stock
  end

  # Read method for a single shoe product (row) in the shoes table
  #
  # Returns a Shoe Object.
  def self.find_as_object(id)

    results = self.find(id)


    Shoe.new(results['id'], results['name'], results['cost'], results['color'], results['category_id'], results['location_id'], results['location_stock'])
  end

  # Creates a new shoe (row) in the shoes table
  #
  # shoe_name - String for the shoe's name
  # cost - Integer for the shoe's cost
  # color - String for the shoe's color
  # category_id - Integer, foreign key from the categories table
  # location_id - Integer, foreign key from the locations table
  # quantity - Integer, to be added to the location_stock column
  #
  # Returns the new Shoe Object created.
  def self.add(shoe_name, cost, color, category_id, location_id, quantity)
    DATABASE.execute("INSERT INTO shoes (name, cost, color, category_id, location_id, location_stock) VALUES ('#{shoe_name}', #{cost}, '#{color}', #{category_id}, #{location_id}, #{quantity});")

    temp_id = DATABASE.last_insert_row_id

    Shoe.new(temp_id, shoe_name, cost, color, category_id, location_id, quantity)

    return self
  end

  # Adds a Shoe Object to the database.
  #
  # Returns id of the object if added - Integer, else returns False.
  def add_to_database
    if Valid.shoe?(self)
      DATABASE.execute("INSERT INTO shoes (name, cost, color, category_id, location_id, location_stock) VALUES ('#{@name}', #{@cost}, '#{@color}', #{@category_id}, #{@location_id}, #{@location_stock});")

      @id = DATABASE.last_insert_row_id
    else
      false
    end
  end

  # Read method for the shoes table
  #
  # Returns an Array containing all rows as Shoe Objects.
  def self.all_as_objects
    # results = DATABASE.execute("SELECT * FROM shoes;")
    results = self.all

    store_results = []

    results.each do |hash|
      store_results << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end

    return store_results
  end

  # Sums all of the product inventory
  #
  # Returns the sum of all location_stock values - Integer
  def self.total_stock
    sum = DATABASE.execute("SELECT SUM(location_stock) FROM shoes;").first

    sum = sum[0]
    return sum
  end

  # Shows all products by cost categories
  #
  # cost_category - String, should be categories of high, medium, or low
  #
  # Returns an Array containing rows as Shoe objects.
  def self.where_cost(cost_category)
    if cost_category == "high"
      results = DATABASE.execute("SELECT * FROM shoes WHERE cost >= 100;")
    elsif cost_category == "medium"
      results = DATABASE.execute("SELECT * FROM shoes WHERE cost >= 50 AND cost < 100;")
    else
      results = DATABASE.execute("SELECT * FROM shoes WHERE cost < 50;")
    end

    store_results = []

    results.each do |hash|
      store_results << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end

    return store_results
  end

  # Reads all products with low quantities in location_stock.
  #
  # Returns an Array containing rows as Shoe Objects.
  def self.where_quantity_is_low
    results = DATABASE.execute("SELECT * FROM shoes WHERE location_stock < 5;")

    store_results = []

    results.each do |hash|
      store_results << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end

    return store_results
  end

  # Updates the shoes table in the database.
  #
  # shoe_name - String for the shoe's name
  # cost - Integer for the cost of the shoe
  # color - String for the color of the shoe
  # category_id - Integer, foreign key from the categories table
  # location_id - Integer, foreign key from the locations table
  # quantity - Integer for the location_stock column
  #
  # Returns true/false Boolean.
  def save

    if Valid.shoe?(self)
      DATABASE.execute("UPDATE shoes SET name = '#{@name}', cost = #{@cost}, color = '#{@color}', category_id = #{@category_id}, location_id = #{@location_id}, location_stock = #{@location_stock} WHERE id = #{@id};")

    else
      return false
    end
  end

  # Updates the quantity of a product for a given id
  #
  # to_add - Integer for the number to add to the location_stock value
  #
  # Returns the location_stock attribute - Integer.
  def update_quantity(to_add)
    DATABASE.execute("UPDATE shoes SET location_stock = #{@location_stock + to_add} WHERE id = #{@id};").first

    @location_stock += to_add

  end

end
