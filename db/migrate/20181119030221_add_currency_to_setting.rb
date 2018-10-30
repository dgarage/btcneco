class AddCurrencyToSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :currency, :string
  end
end
