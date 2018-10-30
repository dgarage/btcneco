class AddEmailTemplatesToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :first_email, :text
    add_column :settings, :thankyou_email, :text
    add_column :settings, :invoice_email, :text
    add_column :settings, :reminder_email, :text
    add_column :settings, :goodbye_email, :text
  end
end
