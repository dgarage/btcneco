class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :invoice_id
      t.string :invoice_url
      t.string :invoice_status
      t.datetime :invoiceTime
      t.datetime :expirationTime
      t.integer :subscription_id

      t.timestamps
    end
  end
end
