# This class stores information regarding promotions when total amount is over
# certain limit
class AmountPromotion
  attr_accessor :min_amount, :reduction

  def initialize(min_amount, reduction)
    @min_amount = min_amount
    @reduction = reduction
  end
end
