class AddBtcpayserverurlToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :btcpayserver_url, :string
  end
end
