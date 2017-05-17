require 'test/unit'
require_relative 'product'
require_relative 'amount_promotion'
require_relative 'item_promotion'
require_relative 'checkout'

# Test suite class
class TestMarkeplace < Test::Unit::TestCase

  # This method acts as before block
  def setup
    @lavender_heart = Product.new("001", "Lavender Heart", 9.25)
    @person_cufflinks = Product.new("002", "Personalized cufflinks", 45.00)
    @kids_t_shirt = Product.new("003", "Kids T-Shirt", 19.95)

    amount_promotion  = AmountPromotion.new(60, 10)
    item_promotion = ItemPromotion.new("001", 8.50)
    @promotional_rules = {amount_promotion: amount_promotion, item_promotion: item_promotion}
  end

  def test_product
    socks = Product.new("004", "Socks", 1.25)

    assert_equal("004", socks.code)
    assert_equal("Socks", socks.name)
    assert_equal(1.25, socks.price)
  end

  def test_amount_promotion
    amount_promotion  = AmountPromotion.new(100, 15)

    assert_equal(100, amount_promotion.min_amount)
    assert_equal(15, amount_promotion.reduction)
  end

  def test_item_promotion
    item_promotion = ItemPromotion.new("004", 0.99)

    assert_equal("004", item_promotion.code)
    assert_equal(0.99, item_promotion.reduced_price)
  end

  def test_checkout_1
    co = Checkout.new(@promotional_rules)
    co.scan(@lavender_heart)
    co.scan(@person_cufflinks)
    co.scan(@kids_t_shirt)
    price = co.total

    assert_equal(66.78, price.round(2), "Price doesn't match")
  end

  def test_checkout_2
    co = Checkout.new(@promotional_rules)
    co.scan(@lavender_heart)
    co.scan(@kids_t_shirt)
    co.scan(@lavender_heart)
    price = co.total

    assert_equal(36.95, price.round(2), "Price doesn't match")
  end

  def test_checkout_3
    co = Checkout.new(@promotional_rules)
    co.scan(@lavender_heart)
    co.scan(@person_cufflinks)
    co.scan(@lavender_heart)
    co.scan(@kids_t_shirt)
    price = co.total

    assert_equal(73.76, price.round(2), "Price doesn't match")
  end
end
