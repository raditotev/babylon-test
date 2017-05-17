# This class stores information about promotion, where if more than one item
# of a kind is purchased, the price is reduced
class ItemPromotion
  attr_accessor :code, :reduced_price

  def initialize(code, reduced_price)
    @code = code
    @reduced_price = reduced_price
  end
end
