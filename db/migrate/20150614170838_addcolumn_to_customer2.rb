class AddcolumnToCustomer2 < ActiveRecord::Migration
  def change
    change_column :customers,:barva,:string, :null=>false
  end
end
