# DatabaseClassMethods
require "active_support"
require "active_support/inflector"

module DatabaseClassMethods

  # Selects all information from a database table
  #
  # Returns an Array of Hashes for each row
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
  # record_id - Integer that is the primary key, id, for the table
  #
  # Returns an Array containing a Hash for the row
  def find(record_id)
    table = self.to_s.pluralize.underscore

    DATABASE.execute("SELECT * FROM #{table} WHERE id = #{record_id};").first
  end

end
