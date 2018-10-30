class AddCurrencyToGoal < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :currency, :string
  end
end
