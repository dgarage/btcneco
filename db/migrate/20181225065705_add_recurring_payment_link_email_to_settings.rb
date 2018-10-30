class AddRecurringPaymentLinkEmailToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :recurring_payment_link_email, :text
  end
end
