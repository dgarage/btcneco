class AddContentToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :content, :text
    add_column :posts, :title, :string
  end
end
