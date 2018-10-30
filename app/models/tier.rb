class Tier < ApplicationRecord
  belongs_to :admin
  #TODO Monetize stuff

  # Notes:
  # - :smallest_unit_amount cannot be Nil
  # - Might need to increase to large values later -> https://github.com/RubyMoney/money-rails#allow-large-numbers

  monetize :amount_cents
end
