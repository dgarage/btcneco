class MonetizeInvoice < ActiveRecord::Migration[5.2]
  def change
    add_monetize :invoices, :amount
  end
end
