class RemoveColumnsFromTier < ActiveRecord::Migration[5.2]
  def change
    remove_column :tiers, :satoshi_amount, :integer
    remove_column :tiers, :smallest_unit_amount, :integer
    remove_column :tiers, :currency, :string
  end
end
