class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.references :admin, foreign_key: true
      t.string :name
      t.string :profile_pic
      t.string :tagline
      t.text :main_info
      t.string :btcpayserver_keypair

      t.timestamps
    end
  end
end
