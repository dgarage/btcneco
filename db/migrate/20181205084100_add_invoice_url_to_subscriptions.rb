class AddInvoiceUrlToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :invoice_url, :string
  end
end
