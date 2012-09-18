class AddInstanceTypeStringToCluster < ActiveRecord::Migration
  def change
    add_column :clusters, :instance_type, :string
  end
end
