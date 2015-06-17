# Validity Check Module

module Valid

  # While loop to check that a response is valid
  #
  # range - Array of valid choices for the user
  # choice - Integer that the user chooses
  #
  # Returns choice - Integer
  def self.response_check(range, choice)
    while !range.include?(choice)
      puts "Please choose an item from the menu:"
      print ">> "
      choice = gets.to_i
    end
    return choice
  end

  # Method to ensure that all fields are valid in a Shoe Object
  #
  # Returns valid - true/false Boolean
  def self.shoe?
    valid = true

    if name.nil? || name == ""
      valid = false
    end

    if cost.nil? || cost == ""
      valid = false
    end

    if color.nil? || color == ""
      valid = false
    end

    if location_stock.nil? || location_stock == ""
      valid = false
    end

    return valid

  end

  # Method to ensure that name field is valid for Location/Category Objects.
  #
  # Returns valid - true/false Boolean
  def self.name?
    valid = true

    if name.nil? || name == ""
      valid = false
    end

    return valid
  end
end
