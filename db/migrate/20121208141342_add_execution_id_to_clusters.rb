class AddExecutionIdToClusters < ActiveRecord::Migration
  def change
    add_column :clusters, :execution_id, :integer
  end
end
