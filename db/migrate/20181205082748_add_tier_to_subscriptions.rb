class AddTierToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :tier_id, :integer
  end
end
