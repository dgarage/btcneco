class ChangeTierIdToBeStringInPosts < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :tier_id, :string
  end

  def down
    change_column :posts, :tier_id, :integer
  end
end
