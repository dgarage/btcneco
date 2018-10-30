class AddPaymentIdToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :uuid, :string
  end
end
