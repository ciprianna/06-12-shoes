# DatabaseInstanceMethods
require "active_support"
require "active_support/inflector"

module DatabaseInstanceMethods

  # Reads a specific field for a given row in a table
  #
  # field - String for the column name to read
  #
  # Returns value of field
  def get(field)
    table = self.to_s.pluralize.underscore

    result = DATABASE.execute("SELECT * FROM #{table} WHERE id = #{@id}").first

    result[field]
  end

  # Deletes a row from a table
  #
  # Returns true/false Boolean
  def delete
    table = self.class.to_s.pluralize.underscore

    DATABASE.execute("DELETE FROM #{table} WHERE id = #{@id};")

  end

end
