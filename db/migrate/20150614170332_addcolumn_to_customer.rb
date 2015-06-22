class AddcolumnToCustomer < ActiveRecord::Migration
  def change
    add_column :customers,:barva,:string
  end
end
