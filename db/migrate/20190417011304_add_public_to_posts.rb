class AddPublicToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :public_post, :boolean
  end
end
