class AddUserIdToCluster < ActiveRecord::Migration
  def change
  	add_column :clusters, :user_id, :integer
  end
end
