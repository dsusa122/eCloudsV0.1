class AddImageToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :image, :string
  end
end
