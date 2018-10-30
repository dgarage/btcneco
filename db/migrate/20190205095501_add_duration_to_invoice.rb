class AddDurationToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :duration, :string
  end
end
