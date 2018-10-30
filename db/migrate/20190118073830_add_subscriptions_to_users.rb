class AddSubscriptionsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :subscription, foreign_key: true
  end
end
