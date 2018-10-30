class AddSatoshiamountToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :satoshi_amount, :integer
  end
end
