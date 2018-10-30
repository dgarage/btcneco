class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.references :admin, foreign_key: true
      t.integer :satoshi_amount
      t.text :description

      t.timestamps
    end
  end
end
