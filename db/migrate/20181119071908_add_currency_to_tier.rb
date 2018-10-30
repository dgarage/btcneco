class AddCurrencyToTier < ActiveRecord::Migration[5.2]
  def change
    add_column :tiers, :currency, :string
  end
end
