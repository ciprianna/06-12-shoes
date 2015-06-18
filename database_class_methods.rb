# DatabaseClassMethods
require "active_support"
require "active_support/inflector"

module DatabaseClassMethods

  # Selects all information from a database table
  #
  # Returns an Array of Objects
  def all
    table = self.to_s.pluralize.underscore

    results = DATABASE.execute("SELECT * FROM #{table};")

    store_results = []

    results.each do |hash|
      store_results << self.new(hash)
    end

    return store_results

  end

  # Locates an existing row in a table
  #
  # record_id - Integer indicating the primary key for the row
  #
  # Returns an Array containing a Hash for the row
  def find(record_id)
    table = self.to_s.pluralize.underscore

    results = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id};").first

    self.new(results)
  end

  # Creates a new row in a given table in the database
  #
  # options - Hash containing information about the Object (attributes
  #           and values)
  #
  # Returns the new Object
  def add(options = {})

    columns = options.keys
    values = options.values

    columns_for_sql = columns.join(", ")
    individual_values_for_sql = []

    values.each do |value|
      if value.is_a?(String)
        individual_values_for_sql << "'#{value}'"
      else
        individual_values_for_sql << value
      end
    end

    values_for_sql = individual_values_for_sql.join(", ")

    table = self.to_s.pluralize.underscore

    DATABASE.execute("INSERT INTO #{table} (#{columns_for_sql}) VALUES (#{values_for_sql});")

    id = DATABASE.last_insert_row_id

    options["id"] = id

    self.new(options)
  end

end
