class AddOriginEmailToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :origin_email, :string
  end
end
