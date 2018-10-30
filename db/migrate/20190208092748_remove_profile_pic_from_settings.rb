class RemoveProfilePicFromSettings < ActiveRecord::Migration[5.2]
  def change
    remove_column :settings, :profile_pic, :string
  end
end
