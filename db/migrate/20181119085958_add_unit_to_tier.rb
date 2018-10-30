class AddUnitToTier < ActiveRecord::Migration[5.2]
  def change
    add_column :tiers, :smallest_unit_amount, :integer
  end
end
