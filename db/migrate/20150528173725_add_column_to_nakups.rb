class AddColumnToNakups < ActiveRecord::Migration
  def change
    add_column :nakups, :customer_id, :integer
    change_column :nakups, :customer_id, :integer, :null=>false
  end
end
