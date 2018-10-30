class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :email
      t.datetime :last_payment_date
      t.datetime :last_email_reminder
      t.string :status

      t.timestamps
    end
  end
end
