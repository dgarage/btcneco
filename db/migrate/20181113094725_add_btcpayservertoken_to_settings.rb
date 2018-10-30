class AddBtcpayservertokenToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :btcpayserver_token, :string
  end
end
