class AddAmountCentsToTier < ActiveRecord::Migration[5.2]
  def change
    add_monetize :tiers, :amount
  end
end
