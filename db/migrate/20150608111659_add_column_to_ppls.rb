class AddColumnToPpls < ActiveRecord::Migration
  def change
    add_column :ppls,:customer_id, :integer
    
  end
end
