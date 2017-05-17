# This class stores information about products
class Product
  attr_accessor :code, :name, :price

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end
end