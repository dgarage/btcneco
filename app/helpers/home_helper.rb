module HomeHelper
  def satoshi_to_btc(satoshi_value)
    number_with_precision( (satoshi_value.to_f / 100000000), precision: 9, strip_insignificant_zeros: true )
  end
end
