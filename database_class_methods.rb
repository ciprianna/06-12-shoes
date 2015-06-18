# DatabaseClassMethods
require "active_support"
require "active_support/inflector"

module DatabaseClassMethods

  # Selects all information from a database table
  #
  # Returns an Array of Hashes for each row
  def all
    table = self.to_s.pluralize.underscore

    # remove "results" TODO
    #results =
    DATABASE.execute("SELECT * FROM #{table};")

  #   hash_keys = results.first.keys
  #
  #   store_results = []
  #   # for_new_object_keys = hash_keys.map {|key| "hash['#{key}']"}s
  #   # for_new_object = for_new_object_keys.to_s.gsub('"', '')
  #   # for_new_object = for_new_object.slice(1..-2)
  #
  # #  binding.pry
  #   results.each do |hash|
  #     object = Shoe.new
  #   #  binding.pry
  #     hash.each do |key, value|
  #       store_temp = hash[key]
  #       object_store = self.new(store_temp)
  #       binding.pry
  #       store_results << object_store
  #     end
  #
  #   end
  #
  #   binding.pry
  #   return store_results

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
