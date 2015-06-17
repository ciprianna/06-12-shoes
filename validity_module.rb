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
  # object - Shoe Object to check values of
  #
  # Returns valid - true/false Boolean
  def self.shoe?(object)
    valid = true

    if object.name.nil? || object.name == ""
      valid = false
    end

    if object.cost.nil? || object.cost == ""
      valid = false
    end

    if object.color.nil? || object.color == ""
      valid = false
    end

    if object.location_stock.nil? || object.location_stock == ""
      valid = false
    end

    return valid

  end

  # Method to ensure that name field is valid for Location/Category Objects.
  #
  # object - Location or Category Object to check name value of
  #
  # Returns valid - true/false Boolean
  def self.name?(object)
    valid = true

    if object.name.nil? || object.name == ""
      valid = false
    end

    return valid
  end
end
