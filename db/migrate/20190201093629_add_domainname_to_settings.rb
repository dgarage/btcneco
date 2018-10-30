class AddDomainnameToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :domain, :string
  end
end
