# Category Class

class Category

  # Assigns an id for identification in instance methods
  def initialize(id)
    @id = id
  end

  # Creates a new category (row) in the categories table
  #
  # category_name - String
  #
  # Returns nothing
  def self.add(category_name)
    DATABASE.execute("INSERT INTO categories (name) VALUES ('#{category_name}');")
  end

  # Read method for the categories table
  #
  # Returns all data from the categories table
  def self.all
    DATABASE.execute("SELECT * FROM categories;")
  end

  # Reads all shoes in a category object
  #
  # Returns all shoes (rows) at that category from the shoes table
  def shoes
    DATABASE.execute("SELECT * FROM shoes WHERE category_id = #{@id};")
  end

  # Update method for the categories table
  #
  # new_category_name - String
  #
  # Returns nothing
  def update(new_category_name)
    DATABASE.execute("UPDATE categories SET name = '#{new_category_name}' WHERE id = #{@id};")
  end

  # Delete a category from the categories table
  #
  # Returns nothing
  def delete
    # INSERT check for current items of said category
    DATABASE.execute("DELETE FROM categories WHERE id = #{@id}")
  end

end
