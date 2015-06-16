# Shoe Class

class Shoe

  attr_reader :id
  attr_accessor :name, :cost, :color, :category_id, :location_id, :location_stock

  # Assigns an id for identification in instance methods
  #
  # id - Integer assigned as the primary key from the id column
  # name - String
  # cost - Integer
  # color - String
  # category_id - Integer, foreign key from the categories table
  # location_id - Integer, foreign key from the locations table
  # location_stock - Integer indicating quantity of product
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
  # Returns an Array containing one Shoe object for the id selected.
  def find
    results = DATABASE.execute("SELECT * FROM shoes WHERE id = #{@id};")

    store_results = []

    results.each do |hash|
      store_results << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end
  end

  # Creates a new shoe (row) in the shoes table
  #
  # shoe_name - String
  # cost - Integer
  # color - String
  # category_id - Integer, foreign key from the categories table
  # location_id - Integer, foreign key from the locations table
  # quantity - Integer, to be added to the location_stock column
  #
  # Returns an Array containing the new Shoe object
  def self.add(shoe_name, cost, color, category_id, location_id, quantity)
    new_object = DATABASE.execute("INSERT INTO shoes (name, cost, color, category_id, location_id, location_stock) VALUES ('#{shoe_name}', #{cost}, '#{color}', '#{category_id}', '#{location_id}', #{quantity});")

    new_object_store = []

    temp_id = DATABASE.last_insert_row_id

    new_object.each do |hash|
      new_object_store << Shoe.new(temp_id, hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end
  end

  # Read method for the shoes table
  #
  # Returns an Array containing all rows as Shoe objects
  def self.all
    results = DATABASE.execute("SELECT * FROM shoes;")

    store_results = []

    results.each do |hash|
      store_results << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end
  end

  # Sums all of the product inventory
  #
  # Returns the sum of all location_stock values - Integer
  def self.total_stock
    DATABASE.execute("SELECT SUM(location_stock) FROM shoes;")
  end

  # Shows all products by cost categories
  #
  # cost_category - String, should be categories of high, medium, or low
  #
  # Returns an Array containing all row information which meets the WHERE
  #   criterion selected. Rows are represented as Shoe objects in the returned
  #   Array.
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
  end

  # Reads all products with low quantities in location_stock.
  #
  # Returns an Array containing all row information which meets the WHERE
  #   criterion. Rows are represented as Shoe objects in the returned Array.
  def self.where_quantity_is_low
    results = DATABASE.execute("SELECT * FROM shoes WHERE location_stock < 5;")

    store_results = []

    results.each do |hash|
      store_results << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end
  end

  # Updates the shoes table in the database.
  #
  # shoe_name - String
  # cost - Integer
  # color - String
  # category_id - Integer, foreign key from the categories table
  # location_id - Integer, foreign key from the locations table
  # quantity - Integer, to be added to the location_stock column
  #
  # Returns newly updated Shoe object
  def save
    saved_data = DATABASE.execute("UPDATE shoes SET name = #{@name}, cost = #{@cost}, color = #{@color}, category_id = #{@category_id}, location_id = #{@location_id}, location_stock = #{@location_stock};")

    changed_data = []
    saved_data.each do |hash|
      changed_data << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end
  end

  # Updates the quantity of a product for a given id
  #
  # to_add - Integer
  #
  # Returns an Array containing the newly updated Shoe object.
  def update_quantity(to_add)
    results = DATABASE.execute("UPDATE shoes SET location_stock = #{@location_stock + to_add} WHERE id = #{@id};")

    store_results = []

    results.each do |hash|
      store_results << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end
  end

  # Deletes a shoe row from the shoes table
  #
  # Returns an Array containing the remaining rows in the shoes table as Shoe
  #   objects.
  def delete
    results = DATABASE.execute("DELETE FROM shoes WHERE id = #{@id};")

    store_results = []

    results.each do |hash|
      store_results << Shoe.new(hash['id'], hash['name'], hash['cost'], hash['color'], hash['category_id'], hash['location_id'], hash['location_stock'])
    end
  end

end
