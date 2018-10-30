class AddInvoiceInfoToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :invoice_id, :string
    add_column :subscriptions, :invoice_status, :string
  end
end
