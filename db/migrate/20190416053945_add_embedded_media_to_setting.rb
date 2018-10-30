class AddEmbeddedMediaToSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :embedded_media, :string
    add_column :settings, :youtube_link, :boolean
  end
end
