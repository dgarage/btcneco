class AddTierToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :tier_id, :integer
  end
end
