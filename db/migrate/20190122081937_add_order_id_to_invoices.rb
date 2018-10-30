class AddOrderIdToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :order_id, :string
  end
end
