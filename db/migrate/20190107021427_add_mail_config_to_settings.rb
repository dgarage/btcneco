class AddMailConfigToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :mail_user_name, :string
    add_column :settings, :mail_password, :string
    add_column :settings, :mail_domain, :string
    add_column :settings, :mail_address, :string
    add_column :settings, :mail_port, :integer
    add_column :settings, :mail_authentication, :string
    add_column :settings, :mail_enable_starttls_auto, :boolean
  end
end
