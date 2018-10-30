class AddRedeemedToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :redeemed, :boolean
  end
end
