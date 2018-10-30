class CreateBtcpayserverlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :btcpayserverlogs do |t|
      t.string :message

      t.timestamps
    end
  end
end
