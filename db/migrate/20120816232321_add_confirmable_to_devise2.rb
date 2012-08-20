class AddConfirmableToDevise2 < ActiveRecord::Migration
  def up
    add_column :users , :unconfirmed_email , :string
  end
end
