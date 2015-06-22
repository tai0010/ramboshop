class ChangeColumnZbozis < ActiveRecord::Migration
  def change
    change_column :zbozis, :nakup_id, :integer, :null=>true
  end
end
