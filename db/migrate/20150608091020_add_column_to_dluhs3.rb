class AddColumnToDluhs3 < ActiveRecord::Migration
  def change
    change_column :dluhs,:customer_id,:integer, :null=>false
  end
end
