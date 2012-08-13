class AddInstanceTypeIdToClusters < ActiveRecord::Migration
  def change
    add_column :clusters, :instance_type_id, :integer
  end
end
