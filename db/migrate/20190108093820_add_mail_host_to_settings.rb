class AddMailHostToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :mail_host, :string
  end
end
