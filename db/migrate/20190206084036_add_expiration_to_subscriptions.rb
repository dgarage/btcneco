class AddExpirationToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :expires_on, :datetime
  end
end
