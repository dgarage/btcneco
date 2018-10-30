class AddAnonymousToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :anonymous, :boolean
  end
end
