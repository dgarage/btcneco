class MonetizeSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_monetize :subscriptions, :amount
  end
end
