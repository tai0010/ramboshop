class AddColumnToZbozis < ActiveRecord::Migration
  def change
    add_column :zbozis, :nakup_id, :integer
    change_column :zbozis, :nakup_id, :integer, :null=>false
  end
end
