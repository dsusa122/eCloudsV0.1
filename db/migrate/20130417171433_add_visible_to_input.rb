class AddVisibleToInput < ActiveRecord::Migration
  def change
    add_column :inputs, :visible, :boolean
    Input.all.each do |inp|
      inp.update_attribute(:visible, true)
    end
  end
end
