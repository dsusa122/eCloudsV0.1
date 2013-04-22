class AddIsPublicToDirectory < ActiveRecord::Migration
  def change
    add_column :directories, :is_public, :boolean
  end
end
