class AddGoogleAnalyticsToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :ga_script, :text
  end
end
