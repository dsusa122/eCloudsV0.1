class AddConfirmableToDevise < ActiveRecord::Migration
  def up
    add_column :users , :confirmation_url , :string
  end
end
