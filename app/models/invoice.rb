class Invoice < ApplicationRecord
  monetize :amount_cents
  belongs_to :subscription
end
