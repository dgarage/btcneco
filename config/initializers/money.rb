MoneyRails.configure do |config|
  # Default currency
  config.default_currency = :usd
  Money.locale_backend = :currency
end
