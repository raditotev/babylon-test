# This class stores and processes information about marketplace checkout
class Checkout

  def initialize args
    @amount_promotion = args[:amount_promotion]
    @item_promotion = args[:item_promotion]
    @cart = []
  end

  # Adds new items
  def scan item
    @cart << item
  end

  # Returns total bill minus promotions if any
  def total
    @current_bill = 0
    @break_down = Hash.new(0)
    @item_in_promotion = ""

    find_items_in_promotion
    items_in_promotion_total
    items_without_discount_total
    total_price
  end

  private

  # Returns hash with product code as key and total number as value
  def find_items_in_promotion
    @cart.each {|item| @break_down[item.code] += 1}
  end

  # Adds the price for all promotional items in the total bill
  def items_in_promotion_total
    @break_down.each_pair do |key, value|
      if key.eql?(@item_promotion.code) && value > 1
        @current_bill += value * @item_promotion.reduced_price
        @item_in_promotion = key
      end
    end
  end

  # Adds the price for all not discounted item in the total bill
  def items_without_discount_total
    @cart.each {|item| @current_bill += item.price unless @item_in_promotion.eql?(item.code)}
  end

  # Returns the total price
  def total_price
    if @current_bill < @amount_promotion.min_amount
      @current_bill
    else
      @current_bill - (@current_bill * @amount_promotion.reduction) / 100
    end
  end
end
