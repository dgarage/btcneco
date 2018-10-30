class AddPemToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :btcpayserver_pem, :string
  end
end
