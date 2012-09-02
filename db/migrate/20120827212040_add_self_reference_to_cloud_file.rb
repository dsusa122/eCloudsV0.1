class AddSelfReferenceToCloudFile < ActiveRecord::Migration
  def change
    add_column :cloud_files, :parent_id, :integer
  end
end
