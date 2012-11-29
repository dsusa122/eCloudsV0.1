class AddApplicationIdToInput < ActiveRecord::Migration
  def change
    add_column :inputs, :application_id, :integer
  end
end
