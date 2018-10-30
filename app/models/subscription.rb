class Subscription < ApplicationRecord
  monetize :amount_cents
  has_many :invoices
end
