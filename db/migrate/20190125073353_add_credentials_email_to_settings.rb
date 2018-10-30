class AddCredentialsEmailToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :user_credentials_email, :text
  end
end
