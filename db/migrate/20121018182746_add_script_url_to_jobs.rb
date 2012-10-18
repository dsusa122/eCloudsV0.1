class AddScriptUrlToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :script_url, :string
  end
end
