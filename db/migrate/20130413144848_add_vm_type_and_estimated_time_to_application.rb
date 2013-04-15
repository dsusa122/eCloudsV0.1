class AddVmTypeAndEstimatedTimeToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :vm_type, :string
    add_column :applications, :estimated_time, :integer
    Application.all.each do |app|
      app.update_attribute(:vm_type, 'c1.medium')
      app.update_attribute(:estimated_time , 20)
    end
  end
end
