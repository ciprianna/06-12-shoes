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

  # Updates/saves a row's information in a table
  #
  # Returns updated Object
  def save
    table = self.class.to_s.pluralize.underscore

    instance_variables = self.instance_variables

    attribute_hash = {}

    instance_variables.each do |variable|
      attribute_hash["#{variable.slice(1..-1)}"] = self.send("#{variable.slice(1..-1)}")
    end

    individual_instance_variables = []

    attribute_hash.each do |key, value|
      if value.is_a?(String)
        individual_instance_variables << "#{key} = '#{value}'"
      else
        individual_instance_variables << "#{key} = #{value}"
      end
    end

    for_sql = individual_instance_variables.join(', ')

    DATABASE.execute("UPDATE #{table} SET #{for_sql} WHERE id = #{self.id}")

    return self
  end

end
