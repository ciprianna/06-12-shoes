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
  # category_id - Integer - MUST match a primary key from categories table
  # location_id - Integer - MUST match a primary key from locations table
  #
  # Returns nothing
  def self.new(shoe_name, cost, color, category_id, location_id)
    DATABASE.execute("INSERT INTO shoes (name, cost, color, category_id, location_id) VALUES ('#{shoe_name}', #{cost}, '#{color}', #{category_id}, #{location_id});")
  end

  # Read method for the shoes table
  #
  # Returns all data from the shoes table
  def self.all
    DATABASE.execute("SELECT * FROM shoes;")
  end

end
