class RemoveFirstEmailFromSettings < ActiveRecord::Migration[5.2]
  def change
    remove_column :settings, :first_email, :text
  end
end
