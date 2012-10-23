class AddInstallationUrlToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :installation_url, :string
  end
end
