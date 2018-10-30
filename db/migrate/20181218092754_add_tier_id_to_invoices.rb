class AddTierIdToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :tier_id, :integer
  end
end
