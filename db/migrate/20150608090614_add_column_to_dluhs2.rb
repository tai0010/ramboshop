class AddColumnToDluhs2 < ActiveRecord::Migration
  def change
    add_column :dluhs,:customer_id, :integer
    
  end
end
