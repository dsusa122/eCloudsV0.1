class AddDirectoryToJobs < ActiveRecord::Migration
  def change
  	remove_column :jobs, :outputdir
    add_column :jobs, :directory_id, :integer
  end
end
